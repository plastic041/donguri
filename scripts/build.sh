echo "removing previous artifacts..."
rm ../dist/donguri16.bdf
rm ../dist/donguri16.ttf

echo "building new font files..."
java -jar BitsNPicas.jar convertbitmap -f ttf -o ../dist/donguri16-base.ttf ../src/donguri16.kbitx
java -jar BitsNPicas.jar convertbitmap -f bdf -o ../dist/donguri16.bdf ../src/donguri16.kbitx

echo "making ligatures..."
fonttools feaLib -o ../dist/donguri16.ttf ligatures/liga.fea ../dist/donguri16-base.ttf

echo "making woff2..."
fonttools ttLib ../dist/donguri16.ttf --flavor woff2 -o ../dist/donguri16.woff2

echo "building nerd fonts..."
echo "using Font Patcher from $1."
fontforge -script $1/font-patcher ../dist/donguri16.ttf --complete --careful -out ../dist/
fontforge -script $1/font-patcher ../dist/donguri16.ttf --complete --careful --mono -out ../dist/

echo "making preview images..."
uv run image.py

rm ../dist/donguri16-base.ttf

echo "Done!"
