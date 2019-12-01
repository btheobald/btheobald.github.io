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
mogrify -monitor -auto-orient -resize "300x225^" -gravity Center -extent 300x225 -quality 80 -sharpen 2 thumb/*;
mogrify -monitor -resize 50% -quality 65 large/*;