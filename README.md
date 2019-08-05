# Simple Mime Type Adder

This script provides a simple and interactive way to add a new mime type based on file extensions.

## Example / Explanation

Say I want Linux to open files with the ".pde" extension with Processing (A certain program). If I go into my file explorer and set Processing as the new default for some .pde file, it will cause all text files to be opened with Processing, which is of course undesireable.

This happens because Linux, as opposed to Windows, does not distinguish files by their extensions, but rather by their "mime type", which can be determined by many different factors of the file, with the file extension just being one option. For a file to be considered a certain mime type though, a configuration file has to exist that specifies a new mime type with certain rules which files fall under it's name. Usually programs bring this configuration with them when being installed, so most of the time, creating a new mime type is not necessary.

But in some cases, for example the program being just a downloaded binary, which does not come with any installer or configuration file, it can be useful to create your own mime types.

## Usage

Run the program in a terminal and follow the prompts. If you run it as root, the mime type will be installed globally, otherwise only for the current user (I would recommend doing the latter by default).

For the "kind" of the file, choose *text*, if the file is readable with a normal text editor (i.e. is not some special binary file type. Examples: source code, markup, log files); choose *image* if the file is some image format (Examples: png, raw, gif); choose *application* if the file is anything else (Examples: binary, 3D mesh, docx).

For the name of the mime type, use something descriptive like the name of the program the files are associated with, some categorical name, or just the file extension itself (if you only have one). Don't use any generic name that might already be in use.

And lastly just list the extensions you want to identify your new mime type (Just write the letters, no dot or star).

You can always just open the created xml file and change things (The path is shown in the "uninstall" line at the end). After any changes, you have to run `update-mime-database $path` with the path up to the "mime" folder (So `update-mime-database "~/.local/share/mime"` if you installed the file non-globally).

## Possible issues

I have only tried the script on Debian and Linux Mint and not very extensively. I don't know if the two paths (for root and non-root) I implemented are the same in every distribution (probably not). So maybe take a look around first.
