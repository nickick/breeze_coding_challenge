# To use
```
    $ bundle install
    $ rake db:migrate db:seed
    $ rails s
```
```
    #in another tab
    $ curl --data 'item%5Bitem_type%5D=fee&item%5Bamount%5D=105.00&item%5Bdate%5D=2015-06-03 16:12:24 -0700' http://localhost:3000/users/1/items
```
