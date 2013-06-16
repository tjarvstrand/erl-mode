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
(require 'semantic/bovine)
(require 'erl-lex)

(defun semantic-erl-setup ()
  "Set up a buffer for semantic parsing of the Erlang language."
  (erl-by--install-parser)
  (erl-lex-setup)
  ;; Parsing
  ;; Environment
  (setq semantic-type-relation-separator-character '("."))
  (setq semantic-command-separation-character ","))

(add-hook 'erlang-mode-hook 'semantic-erl-setup)

(provide 'semantic-erl)

;;; semantic/bovine/erlang.el ends here
