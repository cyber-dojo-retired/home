
echo 'containers:'
echo '   env:'

for line in $(docker run --rm cyberdojo/versioner | grep PORT | tr ' ' '\n')
do
  name="${line%=*}"
  port="${line#*=}"
  echo "      ${name}: \"${port}\""
done
