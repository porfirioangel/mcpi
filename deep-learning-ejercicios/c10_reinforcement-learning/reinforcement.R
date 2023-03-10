# Preparing and processing data
# -----------------------------------------------------------

library(ReinforcementLearning)
data("tictactoe")

head(tictactoe, 5)

tictactoe %>%
  dplyr::filter(Reward == 1) %>%
  head()
tictactoe %>%
  dplyr::filter(Reward == -1) %>%
  head()

tictactoe %>%
  dplyr::filter(State == 'XB..X.XBB') %>%
  dplyr::distinct()

State <- '0,0'
Action <- '4'
NextState <- '4,8'
Reward <- 0
numberscramble <- tibble::tibble(State = State, Action = Action, NextState = NextState, Reward = Reward)
numberscramble

# Configuring the reinforcement agent
# -----------------------------------------------------------

library(hash)
Q <- hash()
for (i in unique(tictactoe$State)[!unique(tictactoe$State) %in% names(Q)]) {
  Q[[i]] <- hash(unique(tictactoe$Action), rep(0, length(unique(tictactoe$Action))))
}

control = list(
  alpha = 0.1,
  gamma = 0.1,
  epsilon = 0.1
)

d <- tictactoe[1,]
state <- d$State
action <- d$Action
reward <- d$Reward
nextState <- d$NextState

currentQ <- Q[[state]][[action]]
if (has.key(nextState, Q)) {
  maxNextQ <- max(values(Q[[nextState]]))
} else {
  maxNextQ <- 0
}

## Bellman equation
Q[[state]][[action]] <- currentQ + control$alpha * (reward + control$gamma * maxNextQ - currentQ)
q_value <- Q[[tictactoe$State[1]]][[tictactoe$Action[1]]]

for (i in 1:nrow(tictactoe)) {
  d <- tictactoe[i,]
  state <- d$State
  action <- d$Action
  reward <- d$Reward
  nextState <- d$NextState
  currentQ <- Q[[state]][[action]]
  if (has.key(nextState, Q)) {
    maxNextQ <- max(values(Q[[nextState]]))
  } else {
    maxNextQ <- 0
  }  ## Bellman equation
  Q[[state]][[action]] <- currentQ + control$alpha * (reward + control$gamma * maxNextQ - currentQ)
}

Q[[tictactoe$State[234543]]][[tictactoe$Action[234543]]]

# Tuning hyperparameters
# -----------------------------------------------------------

Q <- hash()
for (i in unique(tictactoe$State)[!unique(tictactoe$State) %in% names(Q)]) {
  Q[[i]] <- hash(unique(tictactoe$Action), rep(0, length(unique(tictactoe$Action))))
}

control = list(
  alpha = 0.5,
  gamma = 0.1,
  epsilon = 0.1
)

for (i in 1:nrow(tictactoe)) {
  d <- tictactoe[i,]
  state <- d$State
  action <- d$Action
  reward <- d$Reward
  nextState <- d$NextState
  currentQ <- Q[[state]][[action]]
  if (has.key(nextState, Q)) {
    maxNextQ <- max(values(Q[[nextState]]))
  } else {
    maxNextQ <- 0
  }  ## Bellman equation
  Q[[state]][[action]] <- currentQ + control$alpha * (reward + control$gamma * maxNextQ - currentQ)
}

library(hash)
Q <- hash()
for (i in unique(tictactoe$State)[!unique(tictactoe$State) %in% names(Q)]) {
  Q[[i]] <- hash(unique(tictactoe$Action), rep(0, length(unique(tictactoe$Action))))
}

control = list(
  alpha = 0.1,
  gamma = 0.9,
  epsilon = 0.1
)

for (i in 1:nrow(tictactoe)) {
  d <- tictactoe[i,]
  state <- d$State
  action <- d$Action
  reward <- d$Reward
  nextState <- d$NextState
  currentQ <- Q[[state]][[action]]
  if (has.key(nextState, Q)) {
    maxNextQ <- max(values(Q[[nextState]]))
    Q[[tictactoe$State[234543]]][[tictactoe$Action[234543]]]
  } else { maxNextQ <- 0
  }  ## Bellman equation
  Q[[state]][[action]] <- currentQ + control$alpha * (reward + control$gamma * maxNextQ - currentQ)
}
Q[[tictactoe$State[234543]]][[tictactoe$Action[234543]]]

# Define control object
control <- list(
  alpha = 0.1,
  gamma = 0.1,
  epsilon = 0.9
)
# Perform reinforcement learning
model <- ReinforcementLearning(data = tictactoe,
                               s = "State",
                               a = "Action",
                               r = "Reward",
                               s_new = "NextState",
                               iter = 5,
                               control = control)

model$Q_hash[[tictactoe$State[234543]]][[tictactoe$Action[234543]]]

sort(model$Q['.........', 1:9], decreasing = TRUE)

model$Policy['.........']
