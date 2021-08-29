add this to ~/.zshrc:
```
if [ -f ~/zshconfig/.zshrc ]; then
    source ~/zshconfig/.zshrc
else
    print "404: ~/zshconfig/.zshrc not found."
fi
```