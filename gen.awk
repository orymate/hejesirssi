BEGIN { 
    FS="\t"; 
    OFS="\t";
}

{
    if ($3 == $4) { # ékezetben van a hiba
        if ($1 != $3) { # nem ékezettelen az alapminta
            print $1, $2;
        }
        else {
            next;
        }
    }
    else {
        print $1, $2;
        if ($1 != $3) { # ékezetes az alapminta
            print $3, $4;
        }
    }
}
