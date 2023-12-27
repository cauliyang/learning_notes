DOKUMENT=scinote

help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

make:  ## Erstellt das Dokument
	pdflatex $(DOKUMENT).tex -output-format=pdf # Referenzen erstellen
	makeglossaries $(DOKUMENT)
	biber $(DOKUMENT)
	pdflatex $(DOKUMENT).tex -output-format=pdf # Referenzen einbinden
	pdflatex $(DOKUMENT).tex -output-format=pdf # Referenzen einbinden
	make clean


ebook: ## Creates an ebook
	latexml --dest=$(DOKUMENT).xml $(DOKUMENT).tex
	latexmlpost -dest=$(DOKUMENT).html $(DOKUMENT).xml
	ebook-convert $(DOKUMENT).html $(DOKUMENT).epub --language en --no-default-epub-cover

arxiv: ## Creates an arxiv upload
	zip -r upload.zip . -x \*.git\* -x MAKEFILE -x *.zip -x *.pdf

clean: ## Removes all temporary files
	rm -rf  $(TARGET) *.class *.html *.log *.aux *.out *.thm *.idx *.toc *.ind *.ilg figures/torus.tex *.glg *.glo *.gls *.ist *.xdy *.pyg *.acn  *.bbl *blg *cb *cb2 *fls *acr *alg *sta *bcf 

precommit: ## Runs pre-commit hooks
	pre-commit run -a

commit: precommit
	git add .
	aic

sort-bib: ## Sorts the bibliography
	bibtex-tidy --omit=abstract,keywords,video,file --curly --numeric --months --tab --align=13 --sort=key --duplicates=key,doi --sort-fields --strip-comments --trailing-commas --encode-urls --remove-empty-fields -m bib.bib

vale: ## Runs vale
	vale sync
