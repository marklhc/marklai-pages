data { 
  int<lower=1> N;  // total number of observations 
  int<lower=1> J;  // number of clusters
  int<lower=1, upper=J> gid[N]; 
  vector[N] y;  // response variable 
  int<lower=1> K;  // number of population-level effects 
  matrix[N, K] X;  // population-level design matrix 
  int<lower=1> q;  // index of which column needs group mean centering
} 
transformed data { 
  int Kc = K - 1; 
  matrix[N, K - 1] Xc;  // centered version of X 
  vector[K - 1] means_X;  // column means of X before centering
  vector[N] xc;  // the column of X to be decomposed
  for (i in 2:K) { 
    means_X[i - 1] = mean(X[, i]); 
    Xc[ , i - 1] = X[ , i] - means_X[i - 1]; 
  } 
  xc = Xc[ , q - 1];
} 
parameters { 
  vector[Kc] b;  // population-level effects at level-1
  real bm;  // population-level effects at level-2
  real b0;  // intercept (with centered variables)
  real<lower=0> sigma_y;  // residual SD 
  vector<lower=0>[2] tau_y;  // group-level standard deviations 
  matrix[2, J] z_u;  // normalized group-level effects 
  real<lower=0> sigma_x;  // residual SD 
  real<lower=0> tau_x;  // group-level standard deviations
  cholesky_factor_corr[2] L_1; // Cholesky correlation factor of lv-2 residuals
  vector[J] eta_x;  // unscaled group-level effects 
} 
transformed parameters { 
  // group means for x
  vector[J] theta_x = tau_x * eta_x;  // group means of x
  // group-level effects of y
  matrix[J, 2] u = (diag_pre_multiply(tau_y, L_1) * z_u)';
} 
model { 
  // prior specifications 
  b ~ normal(0, 10); 
  bm ~ normal(0, 10); 
  sigma_y ~ student_t(3, 0, 10); 
  tau_y ~ student_t(3, 0, 10); 
  L_1 ~ lkj_corr_cholesky(2);
  // z_y ~ normal(0, 1);
  to_vector(z_u) ~ normal(0, 1);
  sigma_x ~ student_t(3, 0, 10); 
  tau_x ~ student_t(3, 0, 10); 
  eta_x ~ std_normal(); 
  xc ~ normal(theta_x[gid], sigma_x);  // prior for lv-1 predictor
  // likelihood contribution 
  {
    matrix[N, K - 1] Xw_c = Xc;  // copy the predictor matrix
    vector[N] x_gpc = xc - theta_x[gid]; 
    vector[J] beta0 = b0 + theta_x * bm + u[ , 1];
    Xw_c[ , q - 1] = x_gpc;  // group mean centering
    y ~ normal(beta0[gid] + Xw_c * b + u[gid, 2] .* x_gpc, 
               sigma_y); 
  }
} 
generated quantities {
  // contextual effect
  real b_contextual = bm - b[q - 1];
}
