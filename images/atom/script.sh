rm newgallery.html
rm large/*
cd orig-nc
for file in *.JPG; do
  rname=$RANDOM;
  cp -v -f $file '..\large\large-'$file'';
done;

cd ../large

for file in *.JPG; do
  echo '<a href="images\atom\large\'$file'" title=""></a>' >> ../newgallery.html;
done;

cd ../
mogrify -monitor -resize 50% -quality 65 large/*;