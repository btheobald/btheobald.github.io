rm docs -r
bundle exec jekyll build
mv _site docs
git stage *
