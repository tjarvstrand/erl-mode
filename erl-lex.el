;;; semantic/bovine/erlang.el --- Semantic details for Erlang

;; Copyright (C) 2008, 2009, 2011 Eric M. Ludlam
;; Copyright (C) 2003 David Ponce
;; Copyright (C) 2001, 2002, 2003 Vladimir G. Sekissov

;; Author: Vladimir G. Sekissov <svg@surnet.ru>
;;         David Ponce <david@dponce.com>
;; Keywords: syntax

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;

;;; History:
;;

;;; Code:

(require 'semantic)
(require 'erl-by)

(define-lex-simple-regex-analyzer erl-lex-char
  "Detect and create Erlang CHAR tokens."
  "$[\\]?[*\n]"
  'CHAR)

(define-lex-analyzer erl-lex-default-action
  "The default action when no other lexical actions match text.
This action will just throw an error."
  t
  (error "Unmatched Text during Lexical Analysis: %s (%s)"
         (char-to-string (char-after (point)))
         (point)))

(define-lex-regex-analyzer erl-lex-quoted-atom
  "Detect and create a quoted atom token."
  "'"
  (semantic-lex-push-token
   (semantic-lex-token
    'quoted-atom (point)
    (save-excursion
      (semantic-lex-unterminated-syntax-protection 'quoted-atom
        (forward-sexp 1)
        (point))))))

(define-lex-analyzer erl-lex-keyword-or-atom
  "Detect and create an atom or a keyword token."
  (let ((case-fold-search nil))
    (looking-at "[a-z][a-zA-Z0-9_@]*"))
  (let ((type (if (semantic-lex-keyword-p (match-string 0))
                  (symbol-value (upcase (match-string 0)))
                'ATOM)))
    (semantic-lex-push-token
     (semantic-lex-token type (match-beginning 0) (match-end 0)))))

(define-lex-analyzer erl-lex-variable
  "Detect and create a variable token."
  (let ((case-fold-search nil))
    (looking-at "[A-Z_][a-zA-Z0-9_]*"))
  (semantic-lex-push-token
   (semantic-lex-token 'variable (match-beginning 0) (match-end 0)))))

(define-lex erl-lex
  "Lexical Analyzer for Erlang code."
  semantic-lex-beginning-of-line
  semantic-lex-whitespace
  semantic-lex-newline
  erl-lex-quoted-atom
  semantic-lex-string
  semantic-lex-number
  erl-lex-keyword-or-atom
  erl-lex-char
  erl-lex-variable
  semantic-lex-paren-or-list
  semantic-lex-close-paren
  semantic-lex-comments
  semantic-lex-punctuation
  erl-lex-default-action)

(defun erl-lex-setup ()
  "Set up a buffer for lexical analysis of the Erlang language."
  (semantic-lex-init)
  (setq semantic-lex-syntax-modifications '((?' "\"")))
  (setq semantic-lex-analyzer 'erl-lex))

(provide 'erl-lex)

;;; erl-lex.el ends here
