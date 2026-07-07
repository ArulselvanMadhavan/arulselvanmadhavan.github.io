(lang dune 3.16)

(name portfolio)

(source
 (github arulselvanmadhavan/arulselvanmadhavan.github.io))

(authors "Arulselvan Madhavan")

(maintainers "amadhavan@berkeley.edu")

(license MIT)

(package
 (name portfolio)
 (synopsis "Personal portfolio static site generator")
 (depends
  ocaml
  dune
  tyxml
  omd
  cmdliner))
