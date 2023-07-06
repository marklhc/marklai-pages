data { 
  // input for mediator model
  int<lower=1> J;  // total number of clusters
  vector[J] M;  // mediator variable (at level-2)
  int<lower=1> Kw;  // number of effects for the mediator (including intercept)
  matrix[J, Kw] W;  // level-2 design matrix for the mediator (including intercept)
  // input for outcome model
  int<lower=1> N;  // total number of observations 
  vector[N] Y;  // mediator variable (at level-2)
  int<lower=1> Kx;  // number of effects for the outcome (including intercept)
  matrix[N, Kx] X;  // level-1 design matrix for the outcome (including intercept)
  int<lower=1> gid[N];  // cluster ID
} 
transformed data { 
  int Kwc = Kw - 1; 
  int Kxc = Kx - 1; 
  matrix[J, Kwc] Wc;  // centered version of W 
  matrix[N, Kxc] Xc;  // centered version of X 
  for (i in 2:Kw) { 
    Wc[, i - 1] = W[, i] - mean(W[, i]); 
  } 
  for (i in 2:Kx) { 
    Xc[, i - 1] = X[, i] - mean(X[, i]); 
  } 
} 
parameters { 
  vector[Kwc] a;  // fixed effects for M
  vector[Kxc] b;  // fixed effects for Y
  real temp_b0_m;  // intercept for M (with centered predictors)
  real temp_b0_y;  // intercept for Y (with centered predictors)
  real<lower=0> sigma_m;  // residual SD for M
  real<lower=0> tau_y;  // group-level residual SD for Y
  real<lower=0> sigma_y;  // group-level residual SD for Y
  vector[J] z_y;  // unscaled group-level effects 
} 
transformed parameters { 
  // group-level effects 
  vector[J] beta_y = tau_y * z_y; 
} 
model { 
  vector[J] mu_m = temp_b0_m + Wc * a;
  vector[N] mu_y = temp_b0_y + Xc * b; 
  for (n in 1:N) { 
    mu_y[n] = mu_y[n] + beta_y[gid[n]];  // group specific effect
  } 
  // prior specifications 
  a ~ normal(0, 10);
  b ~ normal(0, 10); 
  sigma_m ~ student_t(3, 0, 10); 
  sigma_y ~ student_t(3, 0, 10); 
  tau_y ~ student_t(3, 0, 10); 
  z_y ~ normal(0, 1); 
  // likelihood contribution 
  M ~ normal(mu_m, sigma_m);
  Y ~ normal(mu_y, sigma_y); 
} 
generated quantities {
  real ab = a[1] * b[2];  // indirect effect
  real ab_stdy = ab / sqrt(tau_y^2 + sigma_y^2); 
  real pm = ab / (ab + b[2]);  // proportion mediated
}
