
#file makefile
.PHONY: clean
# unser C Compiler
CC= gcc
# alle Warnings und Optimierung
CFLAGS=-Wall -g -O2
#Linkingflags
LDFLAGS=-g

SRCDIR=src
OBJDIR=obj
BINDIR=bin
EXEFILE=$(BINDIR)/haw $(BINDIR)/bs $(BINDIR)/hallo

# bring alle c Dateien aus dem scr Ordner
srcfiles=$(wildcard $(SRCDIR)/*.c)
# für jede c Datei ein obj Datei
objfiles=$(patsubst $(SRCDIR)/%,$(OBJDIR)/%,$(srcfiles:.c=.o))
# für jede o Datei eine d Datei
deps=$(objfiles:.o=.d)

all: $(EXEFILE)
#include ist eine Makefile-Direktive, die angibt, dass die angegebene Datei (in diesem Fall $(deps)) in die Makefile eingeschlossen werden soll, selbst wenn sie nicht vorhanden ist oder fehlschlägt.
 #Durch das Einbeziehen der Abhängigkeitsdatei kann Make sicherstellen, dass alle erforderlichen Abhängigkeiten berücksichtigt werden, wenn eine Quelldatei neu kompiliert werden muss.
-include $(deps)

# extrahieren der dependencies
# Bedingung für alle D Dateien brauchst du c Dateien
$(OBJDIR)/%.d: $(SRCDIR)/%.c
	@mkdir -p $(@D)
	$(CC) -MM -MT "$@ $(patsubst %.d,%.o,$@)" -MF $@ $<


# erstellen der obj
# er erstellt für jede c Datei eine o Datei
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	# das @ bewirkt das der Befehl mkdir nicht auf der Konsole erscheint, @D  wird verwendet, um den Pfad des Verzeichnisses der aktuellen Ziel-Datei abzurufen, -p um sicherzustellen
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

#verlinke mit print
# linking von o Datei und print.o
# wenn die Dateien nicht existieren, erstellt er diese
$(BINDIR)/%: $(OBJDIR)/%.o $(OBJDIR)/print.o
	@mkdir -p $(@D)
	$(CC) $(LDFLAGS) -o $@ $(OBJDIR)/print.o $<



   #ist eine Option, die angibt, dass cp alle Dateien und Verzeichnisse überschreiben soll, ohne nachzufragen, ob der Benutzer sicher ist, dass er sie überschreiben möchte.
   #der die Verzeichnisse $(OBJDIR) und $(BINDIR) rekursiv entfernt.
clean:
	rm -r -f $(OBJDIR) $(BINDIR)
    # alle werte werten rekursiv überschrieben
install: all
	cp -rf $(BINDIR)/* /bin
