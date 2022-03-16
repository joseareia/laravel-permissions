## Laravel Permissions

Bash script to setup permissions for Laravel projects.

### Installation

Follow this steps to make the script run globally in your machine.

**Note**: Make sure that you have the following directories in your system: `/opt` and `/usr/local/bin`.

```shell
$ git clone https://github.com/joseareia/laravel-permissions
$ cd laravel-permissions
$ chmod +x install.sh laravel-permissions.sh
$ ./install.sh
```

### Usage

While executing the script you can pass a directory of your Laravel project along side with the flag `-p` or just simple run it without any arguments to change the permissions in the current directory as follow.


```shell
// Without any arguments
$ laravel-permissions

// With -p flag followed by the path
$ laravel-permissions -p /some/random/directory
```

It is possible to activate the flag `-w` which will change the permissions as webserver as owner of the project. Make sure you pass the `user` along side with the flag to specify the user of your remote machine.

If any doubts, just run `$ laravel-permissions -h` for some brief help.

### License

This project is under the [GPL-3.0 license](https://www.gnu.org/licenses/gpl-3.0.en.html).
