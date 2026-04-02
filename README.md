# INT132 Linux Fundamentals Shell Scripting Exercise Sets

## Repo Structure

```
.
├── README.md
├── .gitignore
├── set-01/        Class 03–04  Basic Commands & File Viewing
│   ├── setup.sh
│   ├── answers.sh
│   └── test.sh
├── set-02/        Class 05     Directory Structure & Operations
│   ├── setup.sh
│   ├── answers.sh
│   └── test.sh
├── set-03/        Class 06+08  Links, Permissions & Pattern Matching
│   ├── setup.sh
│   ├── answers.sh
│   └── test.sh
├── set-04/        Class 08–10  Advanced grep · find · Variables · Scripting Basics
    ├── setup.sh
    ├── answers.sh
    └── test.sh
```

## How Do I Use It?

0. If you are on WINDOWS, you are likely needed to use `wsl` (WINDOWS subsystem LINUX) or Prof.Olarn's LINUX server to work on this
1. Go the the set you want to practice (`cd` recommended)
2. Switch to your own dedicated branch (`git checkout -b <your-branch-name>`)
3. Run `bash setup.sh`
4. Run `micro answers.sh`
5. Answer the questions
6. Run `bash test.sh` to grade your works

## Sets

| Set | Class | Topics                                                                                                         |
| --- | ----- | -------------------------------------------------------------------------------------------------------------- |
| 01  | 03–04 | type · help · man · cat · tac · head · tail · redirection · pipe                                               |
| 02  | 05    | pwd · cd · ls · touch · mkdir · rmdir · cp · mv · rm                                                           |
| 03  | 06-08 | ln · chmod · find · grep · globbing                                                                            |
| 04  | 08–10 | grep (regex/anchors/flags) · find (exec) · variables · arithmetic · command substitution · parameter expansion |
