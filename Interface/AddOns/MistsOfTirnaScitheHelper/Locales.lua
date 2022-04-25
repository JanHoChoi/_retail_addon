local _, motsh = ...

motsh.L = {
    ["MOTSH Picker"] = "MOTSH Picker",
    ["MOTSH Settings"] = "MOTSH Settings",
    ["Announce To Group"] = "Announce To Group",
    ["Show Combination Preview"] = "Show Combination Preview",
    ["Show On Boss"] = "Show On Boss",
    ["Show Selection Order"] = "Show Selection Order",
    ["Sync With Others"] = "Sync With Others",
    ["Change Selection Colour"] = "Change Selection Colour",
    ["Change Answer Colour"] = "Change Answer Colour",
    ["Reset Settings"] = "Reset Settings",
    ["Settings"] = "Settings",
    ["Reset"] = "Reset",
    ["Picker Scale"] = "Picker Scale",
    ["Picker Transparency"] = "Picker Transparency",
    ["Preview Scale"] = "Preview Scale",
    ["Preview Transparency"] = "Preview Transparency",
	["will now announce to group!"] = "will now announce to group!",
	["will no longer announce to group!"] = "will no longer announce to group!",
	["will now show a preview frame on combination selection!"] = "will now show a preview frame on combination selection!",
	["will no longer show a preview frame on combination selection!"] = "will no longer show a preview frame on combination selection!",
	["will now show during Mistcaller fight!"] = "will now show during Mistcaller fight!",
	["will no longer show during Mistcaller fight!"] = "will no longer show during Mistcaller fight!",
	["will now show selection order!"] = "will now show selection order!",
	["will no longer show selection order!"] = "will no longer show selection order!",
	["is now synced with group members!"] = "is now synced with group members!",
	["is no longer synced with group members!"] = "is no longer synced with group members!",
	["Choice and Answer colours are the same. Colours have been reset to default and the picker has been reset."] = "Choice and Answer colours are the same. Colours have been reset to default and the picker has been reset.",
    ["[%s], [%s], [%s] (MOTSH)"] = "[%s], [%s], [%s] (MOTSH)",
    ["[%s], [%s], [%s] (MOTSH-Addon)"] = "[%s], [%s], [%s] (MOTSH-Addon)",
    ["found %s different solutions to the chosen symbols. Please check your symbols and try again!"] = "found %s different solutions to the chosen symbols. Please check your symbols and try again!",
    ["NO RING"] = "NO RING",
    ["RING"] = "RING",
    ["LEAF"] = "LEAF",
    ["FLOWER"] = "FLOWER",
    ["FILLED"] = "FILLED",
    ["EMPTY"] = "EMPTY",
}

if GetLocale() == "deDE" then
	motsh.L = {
        ["MOTSH Picker"] = "MOTSH Picker", -- not changed
        ["MOTSH Settings"] = "MOTSH Einstellungen",
        ["Announce To Group"] = "Ausgabe an Gruppe",
        ["Show Combination Preview"] = "Zeige Kombinations Vorschau",
        ["Show On Boss"] = "Anzeige im Bosskampf",
        ["Show Selection Order"] = "Zeige Auswahl der Reihenfolge",
        ["Sync With Others"] = "Mit anderen Synchronisieren",
        ["Change Selection Colour"] = "Änderung der Auswahl Farbe",
        ["Change Answer Colour"] = "Änderung der Antwort Farbe",
        ["Reset Settings"] = "Reset Einstellungen",
        ["Settings"] = "Einstellungen",
        ["Reset"] = "Reset", -- not changed
        ["Picker Scale"] = "Picker Skalierung",
        ["Picker Transparency"] = "Picker Transparenz",
        ["Preview Scale"] = "Vorschau Skalierung",
        ["Preview Transparency"] = "Vorschau Transparenz",
        ["will now announce to group!"] = "Ausgabe im Gruppen Chat aktiviert!",
        ["will no longer announce to group!"] = "Ausgabe im Gruppen Chat deaktiviert!",
        ["will now show a preview frame on combination selection!"] = "Wird nun einen Vorschau Rahmen bei der Kombinations Auswahl anzeigen!",
        ["will no longer show a preview frame on combination selection!"] = "Wird nun nicht länger einen Vorschau Rahmen bei der Kombinations Auswahl anzeigen!",
        ["will now show during Mistcaller fight!"] = "Anzeige im Kampf mit Nebelruferin aktiviert!",
        ["will no longer show during Mistcaller fight!"] = "Anzeige im Kampf mit Nebelruferin deaktiviert!",
        ["will now show selection order!"] = "zeigt jetzt die Auswahl der Reihenfolge an!",
        ["will no longer show selection order!"] = "zeigt jetzt die Auswahl der Reihenfolge nicht mehr an!",
        ["is now synced with group members!"] = "Wird mit den Gruppenmitgliedern synchronisiert!",
        ["is no longer synced with group members!"] = "Wird nicht länger mit den Gruppenmitgliedern synchronisiert!",
        ["Choice and Answer colours are the same. Colours have been reset to default and the picker has been reset."] = "Auswahl und Antwort Farben sind gleich. Die Farben und der Picker wurden resetet.",
        ["[%s], [%s], [%s] (MOTSH)"] = "[%s], [%s], [%s] (MOTSH)",
        ["[%s], [%s], [%s] (MOTSH-Addon)"] = "[%s], [%s], [%s] (MOTSH-Addon)",
        ["found %s different solutions to the chosen symbols. Please check your symbols and try again!"] = "%s unterschiedliche Lösungen für die ausgewählten Symbole gefunden. Überprüfe die Symbole und versuche es erneut",
        ["NO RING"] = "ohne Ring",
        ["RING"] = "Kreis",
        ["LEAF"] = "Blatt",
        ["FLOWER"] = "Blume",
        ["FILLED"] = "Gefüllt",
        ["EMPTY"] = "Leer",
	}
elseif GetLocale() == "frFR" then
        motsh.L = {
            ["MOTSH Picker"] = "MOTSH Sélécteur",
            ["MOTSH Settings"] = "MOTSH Paramètres",
            ["Announce To Group"] = "Annoncer au groupe",
            ["Show Combination Preview"] = "Montrer une prévisualisation du résultat",
            ["Show On Boss"] = "Montrer au boss",
            ["Show Selection Order"] = "Montrer l'ordre de sélection",
            ["Sync With Others"] = "Synchroniser avec les autres",
            ["Change Selection Colour"] = "Changer la couleur de sélection",
            ["Change Answer Colour"] = "Changer la couleur de la réponse",
            ["Reset Settings"] = "Réinitialiser les paramètres",
            ["Settings"] = "Paramètres",
            ["Reset"] = "Réinitialiser",
            ["Picker Scale"] = "Taille de la fenêtre",
            ["Picker Transparency"] = "Transparence de la fenêtre",
            ["Preview Scale"] = "Taille de la prévisualisation",
            ["Preview Transparency"] = "Transparence de la prévisualisation",
            ["will now announce to group!"] = "sera désormais annoncé au groupe!",
            ["will no longer announce to group!"] = "ne sera plus annoncé au groupe!",
            ["will now show a preview frame on combination selection!"] = "affichera désormais une prévisualisation du résultat!",
            ["will no longer show a preview frame on combination selection!"] = "n'affichera plus de prévisualisation du résultat!",
            ["will now show during Mistcaller fight!"] = "sera désormais affiché pendant le combat contre Mandebrume!",
            ["will no longer show during Mistcaller fight!"] = "ne sera plus affiché pendant le combat contre Mandebrume!",
            ["will now show selection order!"] = "affichera désormais l'ordre de sélection!",
            ["will no longer show selection order!"] = "l'ordre de sélection ne sera plus affiché!",
            ["is now synced with group members!"] = "est maintenant synchronisé avec les membres du groupe!",
            ["is no longer synced with group members!"] = "n'est plus synchronisé avec les membres du groupe!",
            ["Choice and Answer colours are the same. Colours have been reset to default and the picker has been reset."] = "Les couleurs de Choix et de Réponses sont identiques. Les couleurs et la sélection ont été réinitialisées par défaut.",
            ["[%s], [%s], [%s] (MOTSH)"] = "[%s], [%s], [%s] (MOTSH)",
            ["[%s], [%s], [%s] (MOTSH-Addon)"] = "[%s], [%s], [%s] (MOTSH-Addon)",
            ["found %s different solutions to the chosen symbols. Please check your symbols and try again!"] = "trouvé %s différentes solutions aux symboles choisis. Veuillez vérifier vos symboles et réessayer!",
            ["NO RING"] = "SANS CERCLE",
            ["RING"] = "CERCLE",
            ["LEAF"] = "FEUILLE",
            ["FLOWER"] = "FLEUR",
            ["FILLED"] = "PLEINE",
            ["EMPTY"] = "VIDE",
        }
end