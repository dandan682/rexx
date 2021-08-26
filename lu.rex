#! /usr/local/bin/regina
/* REXX */
say "Hello World!"
card_number = "1234567890123456789"
call luhn
exit

luhn:
digits = card_number
parse value "0" with checksum odd_digits even_digits
do i=length(digits) to 1 by -2
    odd_digits = odd_digits || substr(digits,i,1)
end    
do i=length(digits)-1 to 1 by -2
    even_digits = even_digits || substr(digits,i,1)
end  
say "odd_digits:" odd_digits
say "even_digits:" odd_digits
checksum = sum(odd_digits)
say "checksum:" checksum
do i=1 to length(even_digits)
    checksum = checksum + sum(substr(even_digits,i,1)*2)
end
say "checksum:" checksum
say "resultado:" checksum // 10
return checksum // 10

sum: procedure
arg n 
s = 0
do i=1 to length(n)
    s = s + substr(n,i,1)
end
return s 