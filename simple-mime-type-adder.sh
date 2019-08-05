if [ `id -g` -eq 0 ];then
    # We are running as root
    mimepath="/usr/share/mime"
    
    printf "Your mime type will be installed for everybody (path:\"$mimepath\").\n"
else
    # We are running as non-root
    mimepath="$HOME/.local/share/mime"

    printf "Your mime type will be installed only for the current user (path:\"$mimepath\").\n"
    printf "Run the script as root to install the mime type globally.\n"
fi
printf "\n"

read -p "Kind of the file ([T]ext, [I]mage or [A]pplication?) " -n 1 -r mk
case $mk in
    [Tt]* ) mimekind="text";;
    [Ii]* ) mimekind="image";;
    [Aa]* ) mimekind="application";;
    * ) printf "Invalid option.\n"; exit;;
esac
printf "\n"
read -p "Name for the mime type (lowercase letters and dashes, no spaces!): " mimename
read -p "File extensions to be assigned to this mime type (separated by spaces): " -a mimeextensions

xmlfile='<?xml version="1.0" encoding="utf-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">'
xmlfile="$xmlfile\n    <mime-type type=\"$mimekind/$mimename\">\n        <comment> $mimename file </comment>"
for e in "${mimeextensions[@]}";do
    xmlfile="$xmlfile\n        <glob pattern=\"*.$e\"/>"
done
xmlfile="$xmlfile\n    </mime-type>\n</mime-info>\n"

printf "\nThe following xml file will be installed:\n"
printf "$xmlfile"

read -p "Confirm? [y/n] " -n 1 -r yn
printf "\n"
case $yn in
    [Yy]* ) ;;
    * ) exit 1;;
esac

mkdir -p "$mimepath/packages"

2>/dev/null cp "$mimepath/packages/smtl-$mimename.xml" "$mimepath/packages/smtl-$mimename.xml.bak" 
printf "$xmlfile\n" > "$mimepath/packages/smtl-$mimename.xml"

update-mime-database "$mimepath"

printf "\nTo uninstall, go to \"$mimepath/packages\", delete the \"smtl-$mimename.xml\" file and run \`update-mime-database\`.\n"
