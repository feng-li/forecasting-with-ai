all: slides zip sync

slides:
	jupyter-nbconvert S*/*.ipynb  --to slides  --SlidesExporter.reveal_theme=solarized --SlidesExporter.reveal_scroll=True --SlidesExporter.reveal_transition=fade --SlidesExporter.reveal_width=1366 --SlidesExporter.reveal_height=768

html:
	jupyter-nbconvert **/**.ipynb  --to html

zip:
	rm forecasting-with-ai-slides.zip
	zip -r forecasting-with-ai-slides.zip S*/*.pdf S*/*.slides.html S*/*.ipynb  data README.md requirements.txt -x "*/.ipynb_checkpoints/*" "*/tex/*"

sync:
	rsync -av --delete-excluded --prune-empty-dirs --include '*/' --include '*slides.zip' --include 'data/*' --include '*.ipynb' --include '*.slides.html' --include '*.slides.pdf' --include '*.pdf' --include 'figures/*' --exclude '*' .  ${HOME}/nextcloud/feng.li/forecasting-with-ai/
