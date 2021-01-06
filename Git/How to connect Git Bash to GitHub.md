# How to connect Git Bash to GitHub

### Setup github password terminal:

```
$ git config credential.helper store
$ git push https://github.com/owner/repo.git

Username for 'https://github.com': <USERNAME>
Password for 'https://USERNAME@github.com': <PASSWORD>
```

---

### How to set up git for GitHub:

```
$ git config --global user.name <Your name here>
$ git config --global user.email <your_email@example.com>
```

---

### How to setup git config file:

```
cd ~/.ssh
touch config
nano config
```

Use whatever text editor if you don't like nano.

```
# Github <User> account
Host github.com-<User"
HostName github.com
User git
PreferredAuthentications publickey
IdentityFile ~/.ssh/GitHub/<User"/id_rsa
AddKeysToAgent yes

# Github <User2> account
Host github.com-<User2>
HostName github.com
User git
PreferredAuthentications publickey
IdentityFile ~/.ssh/GitHub/<User2>/id_rsa
AddKeysToAgent yes

# GitLab <User> account
Host gitlab.com/<User"
HostName gitlab.com
User git
PreferredAuthentications publickey
IdentityFile ~/.ssh/GitLab/<User"/id_rsa
AddKeysToAgent yes

# GitLab <User2> account
Host gitlab.com/<User2>
HostName gitlab.com
User git
PreferredAuthentications publickey
IdentityFile ~/.ssh/GitLab/<User2>/id_rsa
AddKeysToAgent yes
```



---
