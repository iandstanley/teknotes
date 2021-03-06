# Holding

There are different ways of holding back packages: with dpkg, apt, 
dselect, aptitude or Synaptic.

## dpkg

Put a package on hold:
```
echo "<package-name> hold" | sudo dpkg --set-selections
```

Remove the hold:
```
echo "<package-name> install" | sudo dpkg --set-selections
```

Display the status of all your packages:
```
dpkg --get-selections
```

Display the status of a single package:
```
dpkg --get-selections <package-name>
```

Show all packages on hold:
```
dpkg --get-selections | grep "\<hold$"
```

## apt

Hold a package:
```
sudo apt-mark hold <package-name>
```

Remove the hold:
```
sudo apt-mark unhold <package-name>
```

Show all packages on hold:
```
sudo apt-mark showhold
```

## dselect

With dselect, enter the [S]elect screen, find the package you wish to 
hold in its present state and press = or H. The changes will take effect 
immediately after exiting the [S]elect screen.

The following approaches are limited in that locking/holding a package 
within aptitude or synaptic doesn't affect apt-get/apt.

## aptitude

Hold a package:
```
sudo aptitude hold <package-name>
```

Remove the hold:
```
sudo aptitude unhold <package-name>
```

## Locking with Synaptic Package Manager

Go to Synaptic Package Manager (System > Administration > Synaptic 
Package Manager).

Click the search button and type the package name.

When you find the package, select it and go to the Package menu and 
select Lock Version.
