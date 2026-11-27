# Updating problem sets: PhD Development Economics II (UZH)

These repos hold problem sets and solutions for a PhD course that was taught at
MIT (14.771) and now runs at the University of Zurich (UZH) as
**PhD Course: Development Economics II**. The TA is Dario Meili
(dario.meili@econ.uzh.ch). Each repo usually holds a problem set `.tex`, last
year's solutions `.tex`, a `.bib`, data files, and sometimes Stata/R code.

The job is to turn last year's MIT material into this year's UZH version. Keep
the economics and the exercises unless told otherwise; the work is adaptation,
consistency and fresh, reproducible solution code.

## Workflow

1. **Inventory first.** List every file, then read the problem set and the
   solutions in full. Diff the problem text in the solutions against the
   current problem set (ignore the red solution blocks) and list every
   difference before editing anything.
2. **Report before large edits.** Summarise what needs updating (institution,
   wording, numbers, bibliography, code) and agree on scope with the TA.
3. **Never overwrite last year's solutions.** Create a new file named
   `psN_YYYY_solutions.tex`, next to the problem set `psN_YYYY.tex`, and leave
   the old file untouched.
4. **Regenerate every number** quoted in the solutions with the new code, and
   check that each one in the text matches the script output.
5. **Compile both documents** (pdflatex → bibtex → pdflatex ×2) and check that
   there are no errors, undefined citations or undefined references.
6. Commit on a branch, push, and open a PR only when asked.

## Instruction sheet (problem set)

- Title: `PhD Course: Development Economics II - Problem Set N`.
  Below it: `TA's email: \href{mailto:dario.meili@econ.uzh.ch}{dario.meili@econ.uzh.ch}`.
- Remove everything MIT-specific: course number 14.771, "MIT Econ remote
  servers", MIT-only recitations, MIT people, Stellar/Canvas links, etc.
- **Remove dates** ("covered in class on September 15", due dates from last
  year). Use "This paper will be covered in class" without a date unless the
  TA gives one.
- **Recitations are not held as sessions.** Recitation material is only given
  as supplementary material. Never write "as we discussed in recitation" or
  announce an extra recitation; write "as covered in the supplementary
  recitation material" instead.
- **Computing hints:** for computationally heavy exercises, point students to
  the **UZH ScienceCloud (S3IT)**, and say that if they don't have access or
  run into problems on their own machine, they can use smaller values of the
  replication/bootstrap counts (R, B) and won't lose points.
- **Software-neutral hints:** if a hint mentions Stata commands, add that R or
  Python (e.g. writing the loop by hand) is fine too.
- Data: "Please download the dataset, `\textit{file.csv}`, ..." rather than
  "Attached is a dataset".
- Use "exercise" for numbered exercises and "section" for sections
  consistently; check internal cross-references (e.g. "as in 5.2") still point
  to the right item.
- For simulation exercises, include an explicit step "Set a seed for
  reproducibility" and say that each replication must get different random
  draws (rather than "change the seed").

## Solutions file

- Same title as the problem set plus ` -- SOLUTIONS`, and the TA email.
- **Problem text must match this year's problem set word for word**; only the
  red `\color{red} ... \color{black}` solution blocks differ.
- **Neutral voice.** Remove last year's TA's first person ("I did this in
  Stata", "I get") and remarks about last year's students ("Some students...",
  "This was broadly what most students found"). Write "we get", and turn
  student remarks into general pitfalls ("A common pitfall here is ...").
- Replace "the attached Stata code" with a reference to this year's script, e.g.
  "The R code that produces all numbers is in `\texttt{psN\_solutions.R}`
  (seed 8005)".
- **When numbers change, re-check the argument.** New simulation results can
  contradict last year's narrative (e.g. a method that "performs better" may
  now under-reject). Rewrite the discussion to match the new results; don't
  just swap numbers.
- For Monte Carlo rejection rates, mention the simulation error (≈ 0.8
  percentage points for a 5% rate with R = 800) and note that figures move
  slightly with the seed.
- Make sure every sub-question in the problem set has a solution.
- Figures and tables `\input`/`\includegraphics`'d by the solutions must be
  produced by the script and committed (e.g. `results.tex`, `figures/*.png`).

## Code for solutions

- Write the solutions in **R** (last year's were usually Stata). Follow the Stata do file,
  and translate it to R, unless there's a good reason to deviate (which should be flagged 
  for me). 
- Use **seed 8005**, set once at the top of the script when there are simulations.
- Main script `psN_solutions.R`: tidyverse style (dplyr, tidyr, purrr), ggplot2
  for figures, `fixest::feols` (`vcov = "hetero"`, `cluster = ~id` if applicable), 
  `etable()` for tables), packages loaded with **pacman** 
  (`if (!require("pacman")) install.packages("pacman");
  pacman::p_load(...)`). kableExtra for LaTeX tables or etable/modelsummary for 
  regressions, 
  furrr (`furrr_options(seed = TRUE)`) to run Monte Carlos in parallel 
  reproducibly.
- Script header: course, TA, what the script reproduces, how to run it, its
  outputs, required packages, and the expected run time with how to reduce it
  (smaller R/B, or ScienceCloud).
- Write all quoted numbers to a text log (e.g. `solution_results.txt`) so
  the solutions can be checked against it.
- Read data with paths relative to the repo root; build unique cluster IDs when
  IDs repeat across groups (e.g. `country_village`).
- In cluster bootstraps, give duplicated clusters new IDs and skip draws with no
  treatment variation.
- State ambiguous modelling choices in a comment and in the solutions (e.g.
  "N(0,3)" read as variance 3).
- Check that the real-data results reproduce last year's numbers; if they
  don't, find out why before changing the solutions.

## Bibliography

- Every `\cite` key must exist in the `.bib`; compile and look for `[?]`.
- Prefer published versions over working papers (cite the WP alongside if the
  text refers to it), and keep key names consistent with the year.
- Fill in missing journal, volume, issue and page/article numbers. Flag any
  reference you are not sure about to the TA instead of guessing.

## Repo hygiene

- `.gitignore`: R project files (`.Rproj.user`, `.Rhistory`, `.RData`,
  `.Ruserdata`, `*.Rproj`) and LaTeX build files (`*.aux`, `*.bbl`, `*.blg`,
  `*.log`, `*.out`, `*.synctex.gz`).
- If PDFs are tracked, rebuild and commit them together with the `.tex` changes.
- Keep the old year's files unchanged so the diff to last year stays visible.
- Amend this Claude.md file if you think there are cross-cutting instructions that might
be relevant for other problem sets as well. But always ask first before amendments to the CLAUDE.md