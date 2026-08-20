echo "removing previous artifacts..."
rm ../dist/donguri16.bdf
rm ../dist/donguri16.ttf

echo "building new font files..."
java -jar BitsNPicas.jar convertbitmap -f ttf -o ../dist/donguri16.ttf ../src/donguri16.kbitx
java -jar BitsNPicas.jar convertbitmap -f bdf -o ../dist/donguri16.bdf ../src/donguri16.kbitx

echo "Done!"
