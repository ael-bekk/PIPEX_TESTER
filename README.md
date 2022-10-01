<h1 align="center">
	42 - PIPEX_TESTER
</h1>

<p align="center">
	<b><i>Tester for your pipex</i></b><br>
</p>

<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/ael-bekk/PIPEX_TESTER?color=blueviolet" />
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/ael-bekk/PIPEX_TESTER?color=blue" />
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/ael-bekk/PIPEX_TESTER?color=brightgreen" />
</p>


# Tester for 42 project 
this tester test your program with some basics testes.</br>
>Note that the tester doesn't check the norm or leak memory

## Preview :
![Screenshot](screen.gif)

## DON'T FORGET TO DO STARE IF THE TESTER HELPED YOU

## How do i run this tester ?

Disclaimer :

To make sure this `tester` work properly you need to clone it in your pipex directory

```
git clone git@github.com:ael-bekk/PIPEX_TESTER.git ; cd PIPEX_TESTER ; chmod +x tester.sh
./tester.sh
```
Modes :
<pre>
-e : error_handling
-m : mandatory
-b : bonus multiple pipes
-h : bonus here doc
-a : all
</pre>

### Example :

Some examples to run this tester :
```
./tester.sh      (all tests)
./tester.sh -a   (all tests)
./tester.sh -p   (test one pipe)
./tester.sh -pem (test multi pipe and err_handling and muli_pipe)
./tester.sh -hp  (test one pipe and here_doc)
```

## 📝 License

This project is licensed under the MIT - see the [LICENSE](LICENSE) file for details.

---
