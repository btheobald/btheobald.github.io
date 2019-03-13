rm newgallery.html
rm large/*
rm thumb/*
cd orig-nc
for file in *.JPG; do
  rname=$RANDOM;
  cp -v -f $file '..\thumb\'$rname'.jpg';
  cp -v -f $file '..\large\'$rname'.jpg';
done;

cd ../thumb

for file in *.jpg; do
  echo '<a href="images\large\'$file'" title="">' >> ../newgallery.html;
  echo ' <img src="images\thumb\'$file'" alt=""></img></a>' >> ../newgallery.html;
done;

cd ../
mogrify mogrify -monitor -resize "300^^x225" -gravity center -crop 300x225+0+0 +repage -quality 80 -sharpen 2 thumb/*;
mogrify -monitor -resize 50% -quality 65 large/*;