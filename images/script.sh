rm newgallery.html
rm large/*
rm thumb/*
cd orig-nc
for file in *.JPG; do
  cp -f $file "..\thumb\thumb-$file";
  cp -f $file "..\large\large-$file";
  cd ../
  
  echo '<a href="images\large\large-'$file'" title="">' >> newgallery.html;
  echo ' <img src="images\thumb\thumb-'$file'" alt=""></a>' >> newgallery.html;
  
  cd orig-nc
done;

cd ../
mogrify -resize 300x225 -quality 80 -sharpen 2 thumb/*;
mogrify -resize 50% -quality 65 large/*;