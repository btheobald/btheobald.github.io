bundle exec jekyll build
rm docs -r
mv _site docs
git stage *
