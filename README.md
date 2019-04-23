# Gettext

Gettext is a Pharo library for locale-aware translations of strings that use standard GNU [gettext](https://en.wikipedia.org/wiki/Gettext) file formats.

## How to load

To load the project to Pharo, evaluate:
```smalltalk
Metacello new
  baseline: 'Gettext';
  repository: 'github://pharo-contributions/Gettext/src';
  load.
```

Besides this, you will need the GNU gettext installed on your machine. For windows, you can find it here: [http://gnuwin32.sourceforge.net/packages/gettext.htm](http://gnuwin32.sourceforge.net/packages/gettext.htm). On macOS, use [Homebrew](https://brew.sh/)
The gettext is needed to work with translation files.

## Translations

In Pharo, the standard historical way how to do translations of strings is to just to send the `translated` message to a string.

```smalltalk
'Hello world' translated.
```

This message invokes the `NaturalLanguageTranslator` to translate the string. If no translator is registered in this class, the original string is returned without any translation.

This approach was used to translate the whole Pharo environment to many languages but has many significant drawbacks. It uses a singleton class which means that you can have only one active translator and so it is harder to do context-aware translations. For example, you may have a web server that needs to use different translators depending on the current session settings. Moreover, it is not easy to translate your application because your strings that need translation are spread in all your code. Plus, the same string may require different translation depending on the application domain.

The Gettext tries to solve these problems, at least partly, while keeping a little piece of backward compatibility. It adds two next translation messages that allow specifying the domain and the language of the translation.

```smalltalk
 'string two' translatedInDomain: 'Gettext-Example'.
'string two' translatedInDomain: 'Gettext-Example' locale: (LocaleID isoString: 'en-US').
```
When the explicit domain is not set, the one named `'pharo'` is used. If the locale is not set, the default installed translator is used.

## Translation process

All strings that use these translation messages are found in the code and exported to a `.pot` file (Portable Object Template).

```smalltalk
GetTextExporter exportTemplate.
```

The `.pot` files contain a header and then templates of the translations. First, the related method is mentioned in a comment. Then it contains the string ID and an empty string as preparation for the tranlation.

```smalltalk
#: AST-Core-Nodes,RBProgramNode>>gtInspectorSourceCodeIn:,RBProgramNode>>gtSpotterCodePreviewIn:
msgid "Source code"
msgstr ""
```
This file is created inside the following folder structure in the image working directory:

```
[po]
      - [pharo]
              - pharo.pot
```

It is created like that because the separate folder is created for every domain and, by default, the only default domain named `pharo` exists. You very likely want to have translations for your own project serparated in a custom domain. You may register classes to the domains using their categories.

```smalltalk
TextDomainManager registerClassCategory: 'MyProject-Core' domain: 'MyProject'.
GetTextExporter exportTemplate.
```
Then the domain specific `.pot` will only contain translations collected from your project and the folder structure will look like:
```
[po]
      - [pharo]
              - pharo.pot
      - [MyProject]
              - MyProject.pot
```

The `.pot` files are only templates and before translation, they need to be converted into `.po` files for particular languages. The utility `msginit` serves for this task.

"C:\Program Files (x86)\GnuWin32\bin\msginit.exe" --locale=de_DE --input=MyProject.pot

This command will create a file named `en_US.po` that you can provide to a translator to assign to every string ID a corresponding translation. There are some third-party GUI tools to work with these files naturally.

When the translation is done, you need to convert the `.po` file into `.mo` file (Machine Object). It is the task for the gettext utility named `msgfmt`:
```
"C:\Program Files (x86)\GnuWin32\bin\msgfmt.exe" -o MyProject.mo de_DE.po
```
This file then will be placed in the corresponding `locale` subfolder of your image directory:

```
[locale]
      - [de_DE]
              - [LC_MESSAGES]
                      - MyProject.mo
```

Some language have different variants depending on the country. In that case, you may use language files for the general language locale (e.g. `en` and put specific  overrides into the country related locales (e.g. `en_US`)

```
[locale]
      - [en]
      - [en_GB]
      - [en_US]
```

If the translation will not be found in the country language, the generic language translation will be tried.

## Image

The translation files can be re-read using the `reset` message.

```smalltalk
GetTextTranslator reset.
```
There is another message named `hardReset` that does more radical cleanup and is useful sometimes.

You can get all the available translators:
```smalltalk
GetTextTranslator translators.
````
But in most cases, you will want just one depending for a locale you are interested in:

```smalltalk
GetTextTranslator availableForLocaleID: (LocaleID isoString: 'en').
```
You can set such a translator as a default system translator or just use it directly.

```smalltalk
NaturalLanguageTranslator current: (GetTextTranslator availableForLocaleID: (LocaleID isoString: 'en-US')).
```

If you are using it directly, use messages like `translate:inDomain:` but be aware that such messages will be not gathered automatically by the `GetTextExporter`

```smalltalk
aTranslator translate: 'string one' inDomain: 'MyProject'.
```

In your own application, you will probably keep some translator instance and related locale in a session or Spec application object.  Then it may be handy to use a custom message. For example, a Seaside component may implement the `translate:` message that will internally use the language and domain depending on the active user settings.

```smalltalk
self translate: 'string'.
```
However, in that case, you will need to create a custom `GetTextExporter` subclass that will correctly identify such messages in your code for the automatic export.


