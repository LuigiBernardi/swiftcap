#'
#' @title
#' Fitting N-Gram Language Models
#'
#' @description
#' Fits an N-Gram language model that can be used for type ahead language
#' prediction.
#'
#' @details
#' Fits an N-Gram language model that conditions the probability of the next
#' word in a phrase based on the previous 'N-1' words.  The previous 'N-1' words
#' in a phrase is known as the context.  The length of the context depends on 'N'.
#' A bigram (2-gram) model leverages only the previous word as the context. A
#' trigram (3-gram) model considers the previous 2 words. A 4-gram model considers
#' the previous 3 words.
#'
#' The maximum liklihood estimate for the probability of a word is calculated as the
#' number of times the phrase occurred in a training corpus divided by the number of
#' times the context occurred.  Consider the phrase "I Love You" and a trigram (3-gram)
#' model.  The probability of the word "You" following the context "I Love" is
#' calculated as follows.  The number of times "I Love You" occurs in the training
#' corpus is divided by the number of times "I Love" occurs.
#'
#' Having calculated the probability of each word for all contexts discovered in the
#' training corpus, the model is able to provide a prediction for the next most likely
#' word.  The model is provided input and searches for a context matching this. The
#' model then chooses the next word with the greatest calculated probability.
#'
#' N-gram models with a larger value of 'N' account for greater context and tend to
#' be more accurate.  These same models also tend to encounter N-grams in practice
#' that were not included in the training corpus.  When this occurs the model has no
#' basis to make a prediction.
#'
#' This model uses the Katz Back-off algorithm to balances these pros and cons. The
#' model uses the training corpus to create multiple internal models with different
#' values of N.  For example, a model may include unigrams, bigrams, and trigrams.
#' The model first consult the model with the greatest value of 'N'.  If the model
#' is unable to provide a prediction the model with the next greatest value of 'N'
#' is consulted.  The prediction is provided by the highest order model with sufficient
#' context to make a valid prediction.
#'
#' @param x The text used to generate the language model.
#' @param N The type of N-Gram models to fit; unigram, bigram, trigram, etc.
#' @param freq_cutoff All N-grams that occur lesser than the cutoff are removed
#'      from the model.
#' @param rank_cutoff The lowest rank to keep in the model.  If only the model's
#'      top 5 suggestions are used, then set the rank_cutoff to 5.
#' @param delimiter The delimiters used to define word boundaries.
#' @return An object of class 'ngram' that can be used to perform type ahead text
#'      prediction.
#' @export
#' @family ngram
#' @examples
#' \dontrun{
#' data (blogs)
#' fit <- ngram (blogs)
#' }
#'
ngram <- function (x, ...) UseMethod ("ngram")
