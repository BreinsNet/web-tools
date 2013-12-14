web-tools
=========

## Description

Web tools is a set of tools to manage LAMP websites across servers. I use it mainly for static / Wordpress and Drupal sites but can be used and extended to any type of sites.

## Install

Just clone the repo and add 755 permissions to files on bin/ directory


## Usage:

This tool is constantly evolved. Documentation is inline on each documentation. Use this as a examples that are probably old at this point

```sh

Usage: /opt/web-tools/bin/wsync [options] src dst

Specific options:
    -a, --all                        Sync files and DB
    -v, --verbose                    Verbose output
    -q, --quiet                      Run quiet mode
    -d, --debug                      Debug the script internals
    -s, --skipdb                     Do not sync database
    -x, --exclude=PATTERN            Specify PATTERN of files to be excluded
        --transfer_type [TYPE]       Select transfer type (*rsync, ftp)

Common options:
    -h, --help                       Show this message
        --version                    Show version

Usage: /opt/web-tools/bin/wbackup [options] label

Specific options:
    -A, --all                        Backup all the sites
    -D, --description DESC           Backup description text
    -s, --skipdb                     Do not backup database
    -f, --skipfiles                  Do not backup files
    -v, --verbose                    Verbose output
    -q, --quiet                      Run quiet mode
    -d, --debug                      Debug the script internals

Common options:
    -h, --help                       Show this message
        --version                    Show version

Usage: /opt/web-tools/bin/winfo [options] src dst

Specific options:
    -F, --filter-label LABEL         Filter by label, used with -b 
    -l, --list                       List all available sites and labels
    -b, --backups                    List all available backups

    -v, --verbose                    Verbose output
    -q, --quiet                      Run quiet mode
    -d, --debug                      Debug the script internals

Common options:
    -h, --help                       Show this message
        --version                    Show version


```

## Examples

```sh

# winfo -l
+-------------+------------------+--------------+
|                 Website list                  |
+-------------+------------------+--------------+
| Label       | URL              | Server       |
+-------------+------------------+--------------+
| dev_example | dev.example.com  | devserver01  |
| prd_example | prod.example.com | prodserver02 |
+-------------+------------------+--------------+

# wbackup prdtpl
Backing up files: OK
Backing up DB: OK

# wsync prdtpl dev02
Syncing website files: OK
Syncing database: OK
Running remote command: OK

 # winfo -b -F prdtpl
+-------+--------+--------------------+-------------+---------------------------+
|                                  Backup list                                  |
+-------+--------+--------------------+-------------+---------------------------+
| Tag # | Label  | URL                | Description | Date                      |
+-------+--------+--------------------+-------------+---------------------------+
| 3     | prdtpl | www.tripleline.com | Automatic   | 2013-12-12 08:29:16 +0000 |
| 4     | prdtpl | www.tripleline.com | Pre upgrade | 2013-12-14 09:35:28 +0000 |
| 5     | prdtpl | www.tripleline.com | Post upgrade| 2013-12-14 18:18:18 +0000 |
+-------+--------+--------------------+-------------+---------------------------+


```

## Need Help or Want to Contribute?

All contributions are welcome: ideas, patches, documentation, bug reports,
complaints, and even something you drew up on a napkin.

It is more important to me that you are able to contribute and get help if you
need it..

## More Documentation

None yet
