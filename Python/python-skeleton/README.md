# Python Skeleton

This is a basic project skeleton to help kick-start a variety of Python projects. It's inspired by [The Hitchhiker's Guide To Python](https://docs.python-guide.org/writing/structure/) and [Real Python's application layout reference](https://realpython.com/python-application-layouts/).


## Usage

Clone this repo to your computer so you can keep getting updates to it. Then copy the whole folder whenever you start a new project. Change all the names to reflect your new project, run the tests to make sure everything works, and then start developing whatever you want!

```bash
$ git clone https://github.com/WeilerWebServices/python-skeleton.git
$ cp -r python-skeleton <your-project>
$ cd <your-project>
$ rm -rf .git/
$ git init
```

*Don't forget to reinitialize git for your new project repo!*

Use grep to find all instances of the name `yourproject` in all the files and change them your project's name. Then add your contact info to `setup.py`.


## Installation

This project skeleton stores dependencies in `requirements.txt`. To install them run `pip install -r requirements.txt` while in an active virtual environment. You can add more with `pip install` and the package name, but don't forget to update the dependency list with `pip freeze > requirements.txt`.

You can run the tests with the `pytest` command. You can learn more about this command and how to write more tests at [pytest's website](https://docs.pytest.org/en/latest/index.html).


## Contributing

If you would like to see changes to this project skeleton, start a conversation as an Issue to discuss your plans.

Pull Requests are always welcome!

