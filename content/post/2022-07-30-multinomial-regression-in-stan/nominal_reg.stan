//
// This Stan program defines a nominal regression model.
//
// It is based on
//   https://mc-stan.org/docs/stan-users-guide/multi-logit.html
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> K;  // number of response categories
  int<lower=0> N;  // number of observations (data rows)
  int<lower=0> D;  // number of predictors
  array[N] int<lower=1, upper=K> y;  // response vector
  matrix[N, D] x;  // predictor matrix
}

transformed data {
  vector[D] zeros = rep_vector(0, D);
}

// The parameters accepted by the model.
parameters {
  vector[K - 1] b0_raw;  // intercept for second to last categories
  matrix[D, K - 1] beta_raw;
}

// The model to be estimated.
model {
  // Add zeros for reference category
  vector[K] b0 = append_row(0, b0_raw);
  matrix[D, K] beta = append_col(zeros, beta_raw);
  to_vector(beta_raw) ~ normal(0, 5);
  y ~ categorical_logit_glm(x, b0, beta);
}

