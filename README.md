#Alchemy Documentation Boilerplate

This boilerplate is intended to be used by [Alchemy](http://www.alchemy.fr)
developers to build documentation for project.

This script copy the boilerplate files to the directory and provides a
consistent design for Alchemy Open-Source project documentation;

##Usage

```bash
./generator.sh <destination> [--force|-f] [--update|-u]
```

##Todo

 - [ ] Generate the documentation (write the doc to the directory, default is *docs*)
 - [ ] Enable the force option (force doc generation - overwrite - on the directory)
 - [ ] Enable the update option (update the doc - only overwrite base files)

The base files are all, except :
 - source/local_conf.py
 - _themes/static/main.js

##License

This generator is licensed under the MIT license
