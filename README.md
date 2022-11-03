# BashSelect.sh
## Easy to use select UI for `bash`

> BashSelect.sh is a simple bash script that let you display a small UI in which you can navigate with the arrow keys.
To select an option you just have to press `ENTER`


[![](https://raw.githubusercontent.com/JulianGransee/BashSelect.sh/main/options.gif)](https://github.com/GermanJag/BashSelect.sh)

---

### Usage

#### Basic usage
1. Copy the script to your code or sourcing it
 ```bash
    source BashSelect.sh
 ```
 2. Export your options
 ```bash
    export OPTIONS=("option 1" "option 2" "option 3")
 ```     
 3. Run the function
 ```bash
    bashSelect
 ```
 4. Get the result (starting at zero)
 ```bash
    echo $?
 ```    


#### Usage in a script

```bash
#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/JulianGransee/BashSelect.sh/main/BashSelect.sh) #sourcing the script so you can use the function "bashSelect" afterwards

export OPTIONS=("say hello" "say bye" "exit") #set the different options

printf 'Use the arrow keys to navigate, press enter to select:\n' #a short explaination never bothers :D

while true; do

bashSelect #run the selector

case $? in #run the corresponding
     0 )
        echo "Hello";;
     1 )
        echo "Bye  ";;
     2 )
        break;;
esac

done
```
