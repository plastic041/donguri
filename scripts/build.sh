mkdir temp

echo "removing previous artifacts..."
rm -rf ../dist

mkdir ../dist

echo "building new font files..."
java -jar BitsNPicas.jar convertbitmap -f bdf -o ./temp/donguri16-latin.bdf ../src/donguri16-latin.kbitx
java -jar BitsNPicas.jar convertbitmap -f bdf -o ./temp/donguri16-base.bdf ../src/donguri16.kbitx
java -jar BitsNPicas.jar convertbitmap -f bdf -o ./temp/donguri16-slim-base.bdf ../src/donguri16-slim.kbitx

echo "merging font files..."
uv run merge.py

echo "building ttfs..."
java -jar BitsNPicas.jar convertbitmap -f ttf -o ./temp/donguri16-base-term.ttf ./temp/donguri16-base-with-latin-term.bdf & 
java -jar BitsNPicas.jar convertbitmap -f ttf -o ./temp/donguri16-slim-base-term.ttf ./temp/donguri16-slim-base-with-latin-term.bdf & 
java -jar BitsNPicas.jar convertbitmap -f ttf -o ../dist/donguri16.ttf ./temp/donguri16-base-with-latin.bdf & 
java -jar BitsNPicas.jar convertbitmap -f ttf -o ../dist/donguri16-slim.ttf ./temp/donguri16-slim-base-with-latin.bdf &
wait

echo "making ligatures..."
fonttools feaLib -o ../dist/donguri16-term.ttf ligatures/liga.fea ./temp/donguri16-base-term.ttf & 
fonttools feaLib -o ../dist/donguri16-slim-term.ttf ligatures/liga.fea ./temp/donguri16-slim-base-term.ttf & 
wait

echo "making woff2..."
fonttools ttLib ../dist/donguri16-term.ttf --flavor woff2 -o ../dist/donguri16-term.woff2  & 
fonttools ttLib ../dist/donguri16-slim-term.ttf --flavor woff2 -o ../dist/donguri16-slim-term.woff2 & 
fonttools ttLib ../dist/donguri16.ttf --flavor woff2 -o ../dist/donguri16.woff2 & 
fonttools ttLib ../dist/donguri16-slim.ttf --flavor woff2 -o ../dist/donguri16-slim.woff2 & 
wait


echo "building nerd fonts..."
echo "using Font Patcher from $1."
fontforge -script $1/font-patcher ../dist/donguri16-term.ttf --complete --careful -out ../dist/ & 
fontforge -script $1/font-patcher ../dist/donguri16-term.ttf --complete --careful --mono -out ../dist/ & 
fontforge -script $1/font-patcher ../dist/donguri16-slim-term.ttf --complete --careful -out ../dist/ & 
fontforge -script $1/font-patcher ../dist/donguri16-slim-term.ttf --complete --careful --mono -out ../dist/ &
wait

echo "making preview images..."
uv run image.py

echo "Done!"

