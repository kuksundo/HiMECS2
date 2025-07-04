        ��  ��                  �  4   �� D E T A I L . C S S         0           /*
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Cascading style sheet used by HTML displayed in detail panes.
 */

body {
  margin: 4px;
  padding: 0px;
}

table {
  margin: 4px 0 0 0;
  border: 0;
}

td {
  vertical-align: top;
  text-align: left;
}

th {
  vertical-align: top;
  text-align: center;
}

.comptable td {
  text-align: center;
}

table.snippet-list td {
  padding: 4px;
}

table.snippet-list td.desc {
  padding-top: 0;
}

h1 {
  margin: 0 0 8px 0;
  padding: 0 0 4px 0;
}

h2 {
  margin: 8px 0 0 0;
}

.active-text h2 {
  margin: 4px 0 0 0;
}

p {
  margin: 4px 0 0 0;
}

ul, ol {
  margin: 4px 0 0 0;
  padding: 0;
  list-style-position: outside;
}

ul {
  list-style-type: disc;
  padding-left: 24px;
}

ol {
  list-style-type: decimal;
  padding-left: 32px;
}

li ol,
li ul {
  margin-top: 0;
}

li {
  padding: 0;
  margin: 0;
}

ul li {
  padding-left: 8px;
}

ul li ol li {
  padding-left: 0px;
}


pre {
  margin: 4px 0;
  padding: 4px;
}

.optionbox {
  margin: 12px 0 0 0;
  padding: 4px;
}

.option {
  margin-top: 2px;
  margin-bottom: 2px;
}

#newtab {
  text-align: center;
  position: fixed;
  top: 30%;
  width: 100%;
  margin-left: -4px;
}

.smallcaps {
  font-variant: small-caps;
}

.box {
  margin: 8px 0;
  border: 1px solid silver;
  padding: 0;
}
.caption {
  font-weight: bold;
  padding: 4px;
  border-bottom: 1px solid silver;
}

#user-db .caption {
  background-color: #D5E0FF;
}

#main-db .caption {
  background-color: #DBD1FF;
}

#compilers .caption {
  background-color: #FCD9F3;
}

#help .caption {
  background-color: #D3FFB6;
}

.content {
  margin: 4px;
}

.content ul {
  margin: 4px 0 4px 24px;
  padding: 0;
}

#footer {
  margin-top: 8px;
  color: gray;
  text-align: right;
  line-height: 150%;
}

#footer a {
  color: gray;
  text-decoration: none;
  font-style: normal;
  font-weight: normal;
}

#footer a:hover {
  border-bottom: 1px dotted grey;
}

.testing-img {
  float: right;
  width: 16px;
  height: 16px;
  padding: 0;
  margin: 2px 0 0 8px;
}

   
  8   �� E A S T E R E G G . C S S       0           /*
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2009-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Cascading style sheet used to format HTML displayed in program's easter egg.
 */


/* styling for body including defaults
   NOTE: font family must be set externally */

body {
  background-color: transparent;
  background-image: url('blue-paper.png');
  color: #3333cc;
  margin: 0;
  padding: 0;
  font-size: 14px;
}

/* styling for segments of slide screen image: sets starting positions for
   animation (ending positions shown in comments) */

.screen {
  display: block;
  position: absolute;
  left: 16px;
}

#screen-top {
  top: 320px;       /* 26px; */
  width: 510px;
  height: 23px;
  z-index: 30;
  cursor: pointer;
}

#screen-middle {
  top: 343px;       /* 48px; */
  width: 510px;
  height: 10px;     /* 304px; */
  z-index: 20;
}

#screen-bottom {
  top: 352px;
  width: 510px;
  height: 270px;
  z-index: 25;
}

/* styling for introductory text and play button displayed after slide screen
   has expanded */

#intro {
  position: absolute;
  top: 52px;
  left: 39px;
  width: 384px;
  height: 200px;
  padding: 40px;
  text-align: center;
  vertical-align: center;
  z-index: 60;
  display: none;
  background-color: transparent;
}

#intro h1 {
  font-weight: bold;
  font-style: italic;
  font-size: 24px;
  margin: 0 0 0 18px;
}

#intro p {
  margin: 12px 0;
  padding: 0;
}

#start {
  cursor: pointer;
  font-style: italic;
}

/* styling for slideshow */

#slideshow {
  position: relative;
  width: 300px;
  top: 62px;
  margin: 24px auto;
  z-index: 100;
  background-color: #773333;
  display: none;
}

#slideshow .caption {
  margin-top: 8px;
  text-align: center;
}

/* styling for prompt and animated arrow that appear as a hint on how to expand
   slide screen */
#click-prompt {
  position: absolute;
  width: 300px;
  left: 121px;
  top: 0px;         /* actual value set by script */
  display: none;
  text-align: center;
  vertical-align: center;
}

#click-arrow {
  position: absolute;
  width: 32px;
  height: 50px;
  left: 255px;
  top: 0px;         /* actual value set by script */
  display: none;
}

/* styling for cancel button that appears at top right of slide screen once it
   has expanded */

#cancel-btn {
  position: absolute;
  width: 16px;
  height: 16px;
  top: 56px;
  left: 486px;
  display: none;
  z-index: 100;
  cursor: pointer;
}

  �  X   �� D L G - A B O U T - D A T A B A S E - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2007-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Template for content displayed in database tab of about dialogue box.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-about-database-tplt.html</title>
    <style type="text/css">
      .scrollbox {
        overflow: auto;
        height: 12em;
        width: auto;
        margin: 6px 48px;
      }
      .contrib-head {
        margin: 0 0 4px 0;
        padding: 2px;
      }
      .tester-head {
        margin: 4px 0;
        padding: 2px;
      }
      .people-list {
        margin: 0 0 0 8px;
      }
    </style>
  </head>

  <body>

    <p>
      The DelphiDabbler
      <a
        class="external-link"
        href="https://github.com/delphidabbler/code-snippets"
      >Code Snippets Database</a> is a resource containing numerous fragments of useful Object Pascal code.<span style="<%LicenseInfoAvailableInline%>"> You are using version <%Version%>.</span>
    </p>

    <div style="<%DBAvailable%>">

      <div style="<%MetaDataAvailable%>">

        <p style="<%LicenseInfoAvailable%>">
          The source code in the database is copyright &copy; <%CopyrightYear%> by <%CopyrightHolders%>. It is made available under the terms of the <%DBLicense%>.
        </p>

        <p style="<%LicenseInfoNotAvailable%>">
          No copyright or licensing information is available.
        </p>

        <p>
          The code is used entirely at your own risk.
        </p>

        <p>
          <strong>Credits</strong>
        </p>

        <p>
          The following people have contributed code to the database, or have helped to test it:
        </p>

        <div class="scrollbox">
          <div class="contrib-head">
            Contributors
          </div>
          <div class="people-list">
            <%ContribList%>
          </div>
          <div class="tester-head">
            Testers
          </div>
          <div class="people-list">
            <%TesterList%>
          </div>
        </div>

      </div>

      <p style="<%MetaDataNotAvailable%>">
        <strong>Credits, License and Copyright information are not available.</strong> The main database may be corrupt. Please use the <em>Database | Install or Update DelphiDabbler Snippets Database</em> menu option to display the <em>Install or Update DelphiDabbler Snippets Database</em> dialogue box and follow the instructions there to get the latest version of the database.
      </p>

    </div>

    <div style="<%DBNotAvailable%>">

      <p>
        <strong>The database is not installed.</strong>
      </p>

      <p>
        You can install it from the <em>Database | Install or Update DelphiDabbler Snippets Database</em> menu option. <a class="help-link" href="help:TaskUpdateCSDB">Learn more</a>.
      </p>

    </div>

  </body>

</html>

K  P   �� D L G - A B O U T - H E A D - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2007-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Template for content displayed in heading of about dialog box.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-about-head-tplt</title>
  </head>

  <body>

    <table style="width:100%;" cellpadding="0" cellspacing="0">
      <tr>
        <td style="text-align:left;">
          <div>
            <strong>DelphiDabbler CodeSnip</strong>
          </div>
          <div style="margin-top:1px;">
            <strong>Code snippets database manager and viewer</strong>
          </div>
          <div style="margin-top:4px;">
            <%Release%>
          </div>
        </td>
        <td style="text-align:right;">
          <img
            src="<%ResURL%>/icon.gif"
            id="icon"
            title="Ctrl click me!"
            style="width:32px;height:32px;margin-right:-1px;text-align:right;"
          />
        </td>
      </tr>
    </table>

  </body>

</html>
 �  T   �� D L G - A B O U T - P R O G R A M - T P L T . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2023, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Template for content displayed in program tab of about dialog box.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-about-program-tplt</title>
    <style type="text/css">
      .scrollbox {
        overflow: auto;
        height: 18em;
        width: auto;
        margin: 6px 0;
      }
      .scrollbox ul {
        margin: 0 0.5em 0 2em;
        list-style-type: disc;
      }
      .scrollbox ul li {
        margin: 0.5em 0;
      }
      .scrollbox ul ul {
        list-style-type: circle;
        margin-top: 0;
        margin-bottom: 0;
        margin-left: 1.25em;
      }
      .scrollbox ul ul li {
        margin: 0.25em 0;
      }
    </style>
  </head>

  <body>

    <p>
      DelphiDabbler <em>CodeSnip</em> is copyright &copy; 2005-2023 by <a
        class="external-link"
        href="https://en.gravatar.com/delphidabbler"
      >Peter D Johnson</a>.
    </p>
    <p>
      The program is made available under the terms of the <a
        class="external-link"
        href="https://www.mozilla.org/MPL/2.0/"
      >Mozilla Public License 2.0</a>. For full details of the license and a
      disclaimer of warranty, please see the file <code>License.html</code> that
      was installed with the program.
    </p>

    <p>
      <strong>Credits &amp; Attributions</strong>
    </p>

    <div class="scrollbox">
      <ul>
        <li>
          The MD5 digest code used in this program is based on the RSA Data
          Security, Inc. MD5 Message-Digest Algorithm.
        </li>
        <li>
          The TListViewEx component used in this program is copyright &copy;
          1999-2009 Vadim Crits.
        </li>
        <li>
          <div>
            <em>CodeSnip</em> makes use of images from the following image
            collections:
          </div>
          <ul>
            <li>
              <span title="broken link removed">Silk Icon Set 1.3</span> by Mark
              James.
            </li>
            <li>
              <span title="broken link removed">Silk Companion 1</span> by Damien
              Guard.
            </li>
            <li>
              <span title="broken link removed">Led Icon Set v1.0</span>.
            </li>
            <li>
              <span title="broken link removed">16&times;16 Free Application
              Icons</span> by Aha-Soft.
            </li>
            <li>
              <span title="broken link removed">PixelBox icon collection</span>.
            </li>
            <li>
              <a
                href="http://toolbaricons.sourceforge.net/"
                class="external-link"
              >Toolbar Icons</a> set by Florian Haag.
            </li>
            <li>
              Public domain images obtained from <a
                href="https://www.clker.com/"
                class="external-link"
              >Clker.com</a>.
            </li>
          </ul>
        </li>
        <li>
          <em>CodeSnip</em> was developed and built using Embarcadero
          Delphi&reg; XE.
        </li>
        <li>
          <em>CodeSnip</em>'s installer was created using
          <a
            href="https://www.jrsoftware.org/isinfo.php"
            class="external-link"
          >Inno Setup</a>.
        </li>
      </ul>

    </div>

  </body>

</html>

   u  `   �� D L G - A C T I V E T E X T - P R E V I E W - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2009-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Template for content displayed in active text preview dialogue box.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-activetext-preview-tplt.html</title>
  </head>

  <body>

    <p>
      Please review the rendered markup below.
      <span id="linktext">Click any link to see its URL and (optionally) open
      it.</span>
    </p>

    <div id="content">
      <%Content%>
    </div>

  </body>

</html>

   �  L   �� D L G - C O M P E R R O R - T P L T . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Template for content displayed in compiler errors dialog box.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-comperror-tplt</title>
  </head>

  <body>

    <div>

      <div style="margin-bottom: 8px;">
        <%Status%> when compiling <strong><%SnippetName%></strong> with
        <strong><%CompilerID%></strong>
      </div>
      <ul style="margin-top: 0px; margin-bottom: 0px;">
        <%ErrorList%>
      </ul>

    </div>

  </body>

</html>
  &  @   �� D L G - D B D E L E T E . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2022, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Warning information displayed in dialogue box used to confirm deletion on the
 * user database.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-dbdelete.html</title>
  </head>

  <body>

    <h1>
      ARE YOU SURE?
    </h1>

    <p>
      Before going any further you are <strong>strongly advised</strong> to take a backup of your snippets database. Use the <em>Database | Backup User Database</em> menu option to do this.
    </p>

    <p>
      <strong class="warning">This action cannot be undone: you will loose all your user-defined snippets.</strong>
    </p>

    <p>
      To confirm enter <code>DELETE</code> <code>MY</code> <code>SNIPPETS</code> (in capital letters) in the box below, then click <em>OK</em>.
    </p>

    <p>
      <strong>There will be no further chances to change your mind.</strong>
    </p>

  </body>

</html>
  �  P   �� D L G - D B U P D A T E - F I N I S H . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2020-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information displayed on the Finish page of the main Database Installation
 * Wizard.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-dbupdate-finish.html</title>
  </head>

  <body>

    <p>
      <strong>The database was installed successfully.</strong>
    </p>

    <p>
      Immediately this dialogue box is closed the database will be reloaded and the newly installed Code Snippets database will replace any earlier version.
    </p>

    <p>
      Click the <em>Finish</em> button to close the dialogue box.
    </p>

  </body>

</html>
  p  X   �� D L G - D B U P D A T E - I N T R O - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2020-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information displayed on the Intro page of the main Database Installation
 * Wizard.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-dbupdate-intro-tplt.html</title>
  </head>

  <body>

    <p class="framed">
      <span class="warning">Warning:</span> you are <strong>strongly advised</strong> to <a class="help-link" href="help:TaskBackupRestore">back up your user database</a> before going ahead with this installation. To do this cancel this dialogue box then use the <em>Database | Backup User Database</em> menu option to create a backup. When you have done that please come back here.
    </p>

    <p>
      Before you can install a new version of the DelphiDabbler Code Snippets Database you need to download it from GitHub.
    </p>

    <p>
      First go to <a
        class="external-link"
        href="<%CSDBReleaseURL%>"
      ><%CSDBReleaseURL%></a> and find the latest version 2 release of the database. Look for a zip file whose name has the form <code>csdb-v2.x.x-data.zip</code> where <code>2.x.x</code> is the database version number.
    </p>

    <p>
      Download the file and unzip it into a folder on your computer. Make a note of the folder's location - it will be needed in the next step.
    </p>

    <p>
      <strong>Note:</strong> Your chosen download folder:
    </p>

    <ul>
      <li>
         <strong>must</strong> be empty before downloading the database.
      </li>
      <li>
        <strong>must not</strong> be a sub-directory of <em>CodeSnip</em>'s application or user data directories.
      </li>
    </ul>

    <p>
      Once the file has been downloaded and unzipped, click the <em>Next</em> button.
    </p>

  </body>

</html>
�  L   �� D L G - D B U P D A T E - L O A D . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2020-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information displayed on the Load page of the main Database Installation
 * Wizard.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-dbupdate-load.html</title>
  </head>

  <body>

    <p>
      Ready to install the new version of the database.
    </p>

    <p>
      Click the <em>Load</em> button to begin the installation.
    </p>

    <p>
      <strong>Note:</strong> Once you have clicked the <em>Load</em> button you cannot cancel the installation process.
    </p>

  </body>

</html>
 �  D   �� D L G - E A S T E R - E G G . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2009-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Content displayed as program's easter egg. References required style sheet
 * and JavaScript code.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>
      dlg-easter-egg
    </title>

    <link rel="stylesheet" href="easteregg.css" />

    <script type="text/javascript" src="jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="jquery.cycle.lite.js"></script>
    <script type="text/javascript" src="easteregg.js"></script>

  </head>

  <body>
    <!-- slideshow screen component images -->
    <img id="screen-top" class="screen" src="screen-top.png" />
    <img id="screen-middle" class="screen" src="screen-middle.png" />
    <img id="screen-bottom" class="screen" src="screen-bottom.png" />

    <!-- main cancel button image -->
    <img id="cancel-btn" src="cancel-btn.png" title="Close" />

    <!-- elements used to prompt user to unfold screen -->
    <img id="click-arrow" src="prompt-arrow.png" />
    <div id="click-prompt">Click the handle!</div>

    <!-- introductory page content -->
    <div id="intro">
      <h1>
        Bonnie &amp; Clyde's
      </h1>
      <p>
        <img src="doggy-pics.png" />
      </p>
      <p>
        <img id="start" src="play-btn.png" title="Start" />
      </p>
      <p>
        Press ESC to finish.
      </p>
    </div>

    <!-- slideshow content -->
    <div id="slideshow">
     <div id="slide-1">
        <img src="dogs-1.jpg" />
        <div class="caption">
          Bonnie &amp; Clyde.<br />
          Our late companions.
        </div>
      </div>
      <div id="slide-2">
        <img src="dogs-2.jpg" />
        <div class="caption">
          Bonnie<br />
          The lights are on but no-one's home.
        </div>
      </div>
      <div id="slide-3">
        <img src="dogs-3.jpg" />
        <div class="caption">
          Clyde<br />
          Resting between bouts of mischief!
        </div>
      </div>
      <div id="slide-4">
        <img src="dogs-sophie.jpg" />
        <div class="caption">
          And now: Sophie<br />
          Fun loving beauty - age 2
        </div>
      </div>
      <div id="slide-5">
        <a
          class="external-link"
          href="https://www.flickr.com/photos/delphidabbler/sets/72157631306758128/"
        ><img src="dogs-4.jpg" /></a>
        <div class="caption">
          More pics on
          <a
            class="external-link"
            href="https://www.flickr.com/photos/delphidabbler/sets/72157631306758128/"
          >Flickr</a>...
        </div>
      </div>
    </div>

  </body>

</html>
  ,  T   �� D L G - R E G I S T E R - C O M P I L E R S . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2022, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Instructions diplayed on Register Compilers dialogue box.
-->

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>Register Compilers Configration</title>
  </head>

  <body>
    <p>
      If you don't wish to receive notifications like this again you have two
      options:
    </p>
    <ol>
      <li>
        <p>
          Turn off <strong>all checks</strong> for new compiler installations.
          Do this by ticking the <em>Don't show this again</em> check box below.
        </p>
        <p>
          If you change your mind later you can re-enable the checks from the 
          <em>Configure Compilers</em> dialogue box.
        </p>
      </li>
      <li>
        <p>
          Turn notifications on or off on a <strong>per-compiler</strong> basis.
          You need to do this after you have closed this dialogue box, again by
          using the <em>Configure Compilers</em> dialogue box.
        </p>  
      </li>
    </ol>
    <p>
      For information about how to configure automatic detection of Delphi
      compilers see the <a
        class="help-link"
        href="help:TaskRegisterCompilers"
      >Register Compilers with <em>CodeSnip</em></a> help topic.
    </p>
    <p>
      <strong>Note:</strong> only Delphi compilers can be automatically
      registered with <em>CodeSnip</em>: this doesn't work with Free Pascal.
    </p>
  </body>
</html>
O  \   �� D L G - S W A G - I M P O R T - I N T R O - T P L T . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2013-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Introductory information displayed on the first page of the SWAG Import
 * Wizard.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-swag-import-intro.html</title>
  </head>

  <body>

    <p>
      This wizard enables you to import &quot;packets&quot; (SWAG's equivalent of CodeSnip's snippets) from the <a
        class="help-link"
        href="help:AboutSWAG"
      >SWAG database</a> into your local user database.
    </p>

    <div class="framed">
      <p>
				You must have a copy of a specially prepared version of SWAG on your local system before continuing. If you haven't already got it then you need to download it from the <em>delphidabbler/swag</em> repository on GitHub.
			</p>
			<p>
				Go to <a class="external-link" href="<%SWAGReleaseURL%>" ><%SWAGReleaseURL%></a> and find the latest supported release&dagger;. The file name will be in the form <code>dd-swag-vX.Y.Z</code> where <code>X.Y.Z</code> is the version number. Download the file and unzip it into a folder on your computer. Make a note of the folder's location - it will be needed in the next step.
			</p>
			<p class="indent">
				&dagger; Currently CodeSnip supports SWAG versions <%SupportedSWAGVersions%>.
			</p>
		</div>

		<p>
			<strong class="warning">Warning:</strong> Although importing snippets should be safe, you may wish to take a backup of your user database before going any further. You can do this from the <em>Database | Backup User Database</em> menu option.
		</p>

    <p>
      On the next page of the wizard you will be asked for the location of the folder containing the SWAG database. <strong>Note</strong> that you will need to specify the <strong><code>swag</code></strong> sub-directory of the download. <em>CodeSnip</em> will then open the database and display all SWAG's categories on the following page. From there you can browse and display the packets in each category before selecting those you want to import. You get a chance to review these before importing.
    </p>

    <p>
      All packets are imported as <a
        class="help-link"
        href="help:SnippetFreeform"
      >freeform</a> snippets.
    </p>

    <p>
			<em>CodeSnip</em> does not keep a track of packets imported from SWAG &ndash; it treats them just like any other user defined snippet. This means it is possible to import the same packet more than once. It's up to you to keep track of this.
    </p>

    <p>
      <strong>Note:</strong> It can take quite some time to import packets from SWAG. You are advised not to import more than about 20 packets in one go. If you want to import a lot of packets you should run this wizard more than once.
    </p>

  </body>

</html>
 �  \   �� D L G - S W A G - I M P O R T - O U T R O - T P L T . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2013-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information displayed on the final page of the SWAG Import Wizard.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>dlg-swag-import-outro-tplt.html</title>
  </head>

  <body>

    <p>
      All the selected SWAG packets have now been converted to CodeSnip snippets
			and imported into the <em><%SWAGCategory%></em> category.
    </p>

    <p>
      The snippets can be edited as required.
    </p>

    <p>
      Click the &quot;Finish&quot; button to close the wizard.
    </p>

  </body>

</html>
  �
  @   �� D L G - W H A T S N E W . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2020-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Content of What's New page optionally displayed whe CodeSnip starts.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>What's New</title>
  </head>

  <body>
		<p class="lead">
			You seem to be updating from a version of CodeSnip prior to v4.16.0.
		</p>
		<p>
			<strong>There are several important differences from your old version of CodeSnip that you need to know about.</strong>
		</p>
		<p>
			<em>Please read carefully because this dialogue box will not appear again.</em>
		</p>
		<p>
			Before v4.16.0, CodeSnip depended for some of its functionality on web services that have now been closed down.
		</p>
		<p>
			The main purpose of CodeSnip v4.16.0 was to remove the program's dependency on the defunct web services. This was done by removing some features and providing alternatives to others.
		</p>
		<p>
			The main changes are:
		</p>
		<ul>
			<li>
				You can no longer check for new releases of CodeSnip or the main DelphiDabbler Code Snippets Database from within the program. The automatic update checker has been removed along with the menu option to check for program updates manually.
			</li>
			<li>
				The DelphiDabbler Code Snippets database can no longer be updated directly from the web. You now have to download the database youself and install it from disk.
				<a
					href="help:TaskUpdateCSDB"
					class="help-link"
				>More info</a>.
			</li>
			<li>
				Similarly the SWAG collection must be downloaded manually before you can import snippets from it. <a
					href="help:AboutSWAG"
					class="help-link"
				>More Info</a>.
			</li>
			<li>
				CodeSnip can no longer be registered.
			</li>
			<li>
				You can no longer submit snippets for inclusion in the DelphiDabbler Code Snippets Database.
			</li>
			<li>
				The news feed has gone away. News will now be posted to the
				<a
					href="https://codesnip-app.blogspot.com/"
					class="external-link"
				>CodeSnip blog</a>. You can display the blog in your web browser from the <em>Help</em> menu.
			</li>
		</ul>
		<p>
			There are other changes to this version of CodeSnip that you can read about in the program's change log. However the ones above are the major departures from how CodeSnip used to work.
		</p>
  </body>

</html>
   �  H   �� I N F O - B A S I C - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2013-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Basic detail pane template that displays basic content within the body.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>Basic Detail Page</title>
    <link rel="stylesheet" href="<%ResourcePath%>detail.css" />
  </head>

  <body>

    <%BodyContent%>

  </body>

</html>W  \   �� I N F O - E M P T Y - S E L E C T I O N - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information pane template used to display an empty list of snippets.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>Empty Snippet List</title>
    <link rel="stylesheet" href="<%ResourcePath%>detail.css" />
  </head>

  <body>

    <h1 class="<%H1Class%>">
      <%Heading%>
    </h1>

    <div class="details">
      <p>
        <%Note%>
      </p>
    </div>

  </body>

</html> 7  T   �� I N F O - S N I P P E T - L I S T - T P L T . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information pane template used to display list of selected snippets with
 * descriptions.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>Snippet List</title>
    <link rel="stylesheet" href="<%ResourcePath%>detail.css" />
    <script type="text/javascript" language="JavaScript">
      <%externalScript%>
    </script>
  </head>

  <body>

    <h1 class="<%H1Class%>">
      <%Heading%>
    </h1>

    <div class="details">
      <p>
        <%Narrative%>
      </p>
      <table class="snippet-list" cellspacing="1" cellpadding="0">
        <%SnippetList%>
      </table>
    </div>

  </body>

</html>
 �  L   �� I N F O - S N I P P E T - T P L T . H T M L         0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Information pane template used to display details of currently selected
 * snippet.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>detail-info</title>
    <link rel="stylesheet" href="<%ResourcePath%>detail.css" />
    <script type="text/javascript" language="JavaScript">
      <%externalScript%>
    </script>
    <script type="text/javascript" language="JavaScript">
      <%overflowXFixScript%>
    </script>
  </head>

  <body>

    <div class="details">

      <div>

        <div style="<%TestingInfo%>">
          <%TestingInfoImg%>
        </div>

        <div
          id="editlink"
          class="option"
          style="<%EditLink%>
            padding:0;margin:0 0 0 8px;position:relative;float:right;"
        >
          <a
            id="editimglink"
            class="command-link"
            href="#"
            onclick="<%EditEventHandler%>;return false;"
          ><img
            src="<%ResourcePath%>editsnippet.gif"
            class="option-img"
            style="width:16px;height:16px;vertical-align:middle;"
            title="Edit Snippet"
          ></a>
          <a
            id="edittextlink"
            class="command-link menu-item"
            style="line-height: 150%;";
            href="#"
            onclick="<%EditEventHandler%>;return false;"
          >Edit Snippet</a>
        </div>

        <h1 id="snippetname" class="<%SnippetCSSClass%>">
          <%SnippetName%>
        </h1>

      </div>

      <div id="details">
        <%SnippetPageFragments%>
      </div>

    </div>

  </body>

</html>   �  @   �� W E L C O M E - T P L T . H T M L       0           <?xml version="1.0"?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<!--
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2005-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Template for welcome page displayed in any detail pane.
-->

<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

  <head>
    <title>Welcome</title>
    <link rel="stylesheet" href="<%ResourcePath%>detail.css" />
    <script type="text/javascript" language="JavaScript">
      <%externalScript%>
    </script>
  </head>

  <body>

    <h1>
      <em>CodeSnip 4</em> by DelphiDabbler
    </h1>

    <div class="details">

      <div id="user-db" class="box">
        <div class="caption">
          Local User database
        </div>
        <div style="<%HaveUserDB%>">
          <div class="content">
            There are <em><%UserDBCount%></em> snippets in the local user
            database.
          </div>
          <div class="content">
            <a
              href="#"
              class="command-link"
              onclick="newSnippet();return false;"
            >Add another snippet</a>
          </div>
        </div>
        <div style="<%NoUserDB%>">
          <div class="content">
            <em>No user defined snippets have been created yet.</em>
          </div>
          <div class="content">
            <a
            href="help:TaskAddSnippets"
            class="help-link"
          >Learn how to create your own snippets</a>
          </div>
        </div>
      </div>

      <div id="main-db" class="box">
        <div class="caption">
          DelphiDabbler Code Snippets database
        </div>
        <div style="<%HaveMainDB%>">
          <div class="content">
            There are <em><%MainDBCount%></em> snippets in the DelphiDabbler
            Code Snippets database.
          </div>
        </div>
        <div style="<%NoMainDB%>">
          <div class="content">
            <em>The <a
              href="https://github.com/delphidabbler/code-snippets"
              class="external-link"
            >DelphiDabbler Code Snippets Database</a> has not been
            installed.</em>
            <a
              href="help:TaskUpdateCSDB"
              class="help-link"
            >Learn more</a>
          </div>
          <div class="content">
            <a
              href="#"
              class="command-link"
              onclick="updateDbase();return false;"
            >Install it now</a>
          </div>
        </div>

      </div>

      <div id="compilers" class="box">
        <div class="caption">
            <span
              style="float:right"
            ><a
              href="help:CompChecks"
              class="help-link"
            ><img
              src="<%ResourcePath%>help.gif"
              class="option-img"
              style="width:16px;height:16px;"
              title="About compiler checks"
            /></a></span> Compilers
        </div>
        <div style="<%HaveCompilers%>">
          <div class="content">
            The following compilers have been configured for running test
            compilations within <em>CodeSnip</em>:
          </div>
          <div class="content">
            <ul>
              <%CompilerList%>
            </ul>
          </div>
          <div class="content">
            <a
              href="#"
              class="command-link"
              onclick="configCompilers();return false;"
            >Change compilers</a>
          </div>
        </div>
        <div style="<%NoCompilers%>">
          <div class="content">
            <em>No Pascal compilers have yet been configured to perform test
            compilations from within CodeSnip.</em>
          </div>
          <div class="content">
            <a
              href="#"
              class="command-link"
              onclick="configCompilers();return false;"
            >Configure compilers</a>
          </div>
        </div>
      </div>

      <div id="help" class="box">
        <div class="caption">
          <span
            style="float:right"
          ><a
            href="help:#"
            class="help-link"
          ><img
            src="<%ResourcePath%>help.gif"
            class="option-img"
            style="width:16px;height:16px;"
            title="Help Contents"
          /></a></span>
          Help
        </div>
        <div class="content">
          Choose a help topic:
        </div>
        <div class="content">
          <ul>
            <li>
              <a
                href="help:QuickStart"
                class="help-link"
              >Quick Start Guide</a>
            </li>
            <li>
              <a
                href="help:Tasks"
                class="help-link"
              >Common Tasks</a>
            </li>
            <li>
              <a
                href="help:FAQs"
                class="help-link"
              >FAQs</a>
            </li>
          </ul>
        </div>
      </div>

      <div id="footer">
        <a
          href="#"
          class="command-link"
          onclick="showNews();return false;"
        >News Blog</a>
        |
        <a
          href="#"
          class="command-link"
          onclick="showAboutBox();return false;"
        >About&nbsp;CodeSnip</a>
      </div>

    </div>

  </body>

</html> `  0   �� I C O N . G I F         0           GIF89a    �     ("�*$�,%�,&�0*�60�94�;6�C=�D?�EA�GB�FE�ID�JF�LF�LJ�SR�VS�XU�[W�[]�d_�ee�df�hg�on�pp�rs�uw�wx�}~�~����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������                                                                                                                                                                                                                                                                                                      !�  � ,         � �	H�����(YȰa�&*�D�b���2i��JD�9)tHrᒏC����b���LA�O%ő%��h��J�5f�8S"Ş,+j��ɞ� �JMZ�i&)��x��s*UN��.�����)�����%>U�Xa�`ϵ_/U�[I����~U��R�H�1b8�&�TN�(�!B�*�dɦ!H~�P�T(M�G�u�b'P暓"M|�	hX����� -� C��J=�ܹ�M0DZ�z�CZl�CG��JbO����R���Lx`�� <4x���CɗkrP#R�P`�!x�t�QB f w� J�7���@�h�@D���`A�HJܗ�*���!�̱�h� D,�p�b w�F���	�ǁr��Fk�Q�_x�p(qb�Z�a�T��j�!^$�ro��ď�Gݥ	��b��DC ��JPie�%��f�ew1�ȩ1�i�ٝ�L:
e�H�)D>��DQ(�g�J~�fj*�=��ZJ�B=�Ɯbԉ(�����:�*Ч��Y衉.D�꠬��YeFh�i��.���f����BAӷ ;-  <   �� E D I T S N I P P E T . G I F       0           GIF89a  �     WB4h�5i�6j�7k�;m�?p�<s�?v�Az�B|�Mz�M|�c��E��E��G��G��J��J��L��N��P��R��T��T��T��T��Y��Z��O��Q��U��b��f��i��k��e��s��|��b��b��`��e��g��d��h��}��n���f.�a+�z�h&��C��L��pHɅAŘI̖XНFژIۙKٛQؚTșdإXףcԢjնzֹv�Q�w��U��[��^��_��m��w��x��y��}��c��l��y��{��z��Z��[��]�����ݚ����������������������۱�ѷ��ͯ�˶�ư�Ƴ�Ծ�ֽ����Ձ�ǔ�ɑ�Ҭ�װ�Ӯ�Ҵ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������                                                                                                                                                                                                                                                !�  � ,       � ��A၃6d ��C�'8��"(N�`�x��é?�	򳇌�4C������B�ħ��$uJ�����KD�
���7t,�iJQ�E������"BZ�ȑ�6Q25�r���(Q���I&&X���D�a�P� �9ri��*>�|��p��G[��Q�
=�PAp�#���ؑ� A�8|�)�8qt�0�ÇU.�#��8���ⅅ�Dzт�*R�X���:M�D]ҧ�V�b�0̈�
 ��b� ;   �k  <   �� B L U E - P A P E R . P N G         0           �PNG

   IHDR    v   d�}   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  kbIDATx^��	��F�����ݵ�10���˅mL1؀)��7�y:yN��|S���\=O5�P=���}���'��AR�B[�?�Һ8%Ť}�����_����cF�`F ���Hw����ׅ9xƛ����g�����W�鯋��Y��,|�����]���~�����֧/�.�t�?�t���6-m�@��ߡ۩tl�C�I����RN��]ʬ��w��5]����e�h��k��\�g,X��we��wC:��:��:B���6]�<<�4n��:g�SN�=C��\�P�8��K�[�#�R����Rc"UNױ]�������CD[�۠�VO]��{���f��2�������ojG[.mw�ƥ.�]�W%h�}ʭs�.@�'m������.��rm�1��w4��GG�w ���[�:t4)]������_'��`�1�So�{%�w��l}p�&��Q.|�[����n��5�k[��{�ϻ8�׬�ٷN׾w)�Vf}h���z߯w�À��P�O��\��m��Qw��)�y��=����}u��ZV�u��G����'���{��|�j��w�ҷ��;���._�R��\��M���鹞������Ǻ����e���)����W����4��pT�L�7)v��[k'.嬷u���G�3��c���k�b�`�\k��ǡ��v|�m��V�d]�e� B�p-�66��V�)�
��W��꣫��ͯbW��{�z�l�L�N�헶;}����U!��;��n�3��&�6�ٮ�^��Ø��X��0����{���&������۞S�������"M�u�]�[~�]�u�~H5¥~W�z�z�����Y���^a��o�K�%�ax�{�>�Q<l�h��p�oz8�4�.eڮ������5�_�݆�ެ8�Ź���
j��^�l'�=C;�l�a�pq�)]�d'}���ُr��S�j֎����M��w��s����(]��� �j\�z��w�=q`�6T���&廃�̏��`+��ye`a�T�54l�����B�߻>a����u����=��<
(��tX�P렱��w��b���Q�{�:o�H9��˱h�����}ȱ����<��l>,x(�
�*e<��0X؜%��O�}�աw�!���
tT�o޸����|&��l�����v}HGI]� F,le��ݵ�(m���'Ƽ��+��+�th@�,\��:ۇ:��8�n�>�xY�Ь�z�~x��c�K�@�N� �7�e��:�P����{+�*@Le�r���`\����'̂Z�Z�"I ,\ �	>��@�K[q�ݜ}��\�`�Z�Z1tb��թu�	X,�ǿ.�\wt���řk�6���.w�*V��v	y�]X����q*���W]���4�����߻��y�J��ѻ;��cX ���0a� kp4����޿�X��5�4���YR�� @E�PA�&I�!�1��]�53��q{}[�\���Ya�<��xE��x���}�q, ���"�0��� �3����@�������[_ܪ]Z@<B;K�s���?X�r�1/�%A��H�0��6k8�
���7��M�i-xԅXp��>�X����6�6YiSe^�QJP+�B��S���i����3[6�#�Ӥ.;� ��*�EX�;|�J���N��$��]Ć��A@r��
�"e� �Q$��	�H:�h����~7�G��$$��X )�E*j���@�ЩV ̀�>9>�5�{ ��`��1������9���`�� ���(M@���U�W^ɥ9C�z߁��PA�&I���CS?�
�P�Z�]�h��e�p���/m��ν��t ��*���M�3B �`�Z!. �����O���H*H��(i��+�I���+4H]ߴ+m���鴱��`�2X���?�
�ja�j�(�ah�������t�!�`�,�C �����I$}����{G���%ӇR?�
�BT�Ҧʼ
V�ԫT�V�@Řa4�=o�k�lM��è>�X ���W}��D�z���
���c�� �|>/���Ua���I� *�����0�0���I(iS3��5<����:��v�8�pQ��f}͇*�̢X��b���O�>�B'TA�Ln.n����tС*XKhQ,�6ɯ�kj�{��Q�WҴ�'�X��S�{v6s���cp� *�l�a�HU=�/�
�
U #)'m� -��;j��0��`�	�p��:�B���)���"�k��|��p�����Z� *�
O� i��M֮Hpua�@�o�Q,UP���6 ����M�b�� a b�HU=�/�
�jI�$m�s�� �˵6գq:��F ��Ma�@�@�@�HP�0�a�"v�j�]@��5�WV���Yq��Ym�%x P1�J���X�V�V����
� i�AZA�*l�a�Ov�W/� :�"t� �� �`���K&e���T��S�Wg5�Y�g�}B`a����M����	�2j{��
r+��!)8�� :��K=M��d����TՃ��B� ,T)#�E�Q�'q�P.�a�����u�0T�V�V��IҦK�g.N:�~�C�2��,l�m�X�\���"e���M�6m�;��W�_���]Q>js<���E�pA��:�B���%ZJ�'BĖ��t>�0���E����lm�nI<���0a� 	�A���"#�"�0�<ڠ���8n���yq��0X����j�N��� 2�Ab�9ȩ�������`4]s�ޑ[r�I	j�
�
�
Ԋ�
V�$�A�*\��y:mu�| $m�6ॎ��&u���_���A ���.��k�a�.H�>/G���eYBjE6Pa�=�Ad���oK��C*�I]��,P+�q� 2Z�/X��L=��:RUB��Bo��蟸�Sdl}�6��M��]����kw,����>�z,Hh�j}��N��*��V�	�d�/�tϯ��2d����0���<v_�-��NU&Hj�B'T0Ŵ�RQ-��W|.�W+�d�Vؠ��|/�n����h`�,P+d�"'c?��"C��,���"�ַnj�,�cY���9�t��1��u���!i�0a�䦘>々>��c�?T�@�N� �Z�ѥͨL1�a�0	�jE�k��,��0�� Ҙ�1���\�B'X�Q$7s)KX����6�>"�PAnEf�a��
 m`�vn>����v�
��T�
�
���BW(,P+rU+|���g��̋�ϯ�`�,P+d������p "$mf�X��V�s���q���D���`�b�C �� �+��Ca�����,| Ĩo��\�@�N� "�V �jEF`!��6}� �=:��i�]@�> �`�FApI���FX�����a@���
��
Ԋ��\�"��v^�}|֨tT�[6f����w1E�@�Hp ��,P+B������mq��s+t�*��G�`�Z!�;��'�A���\(�bjs�1�?z�Hx E�!!�"LH�nġ��͌��0H�pak{�-r����0��ZXd��a�sN��x��V�-�E�D]���b��%�=��j����)C�Tߎ��r�]2�|ѧ|d	�P�Z1< �B`X��j���ͱ�?��+��M�H<��
�^������D,�!i�{?�\ c*\����ڕ�,�B*P+��_ �
�63�
� �@��t��.�9��� ,d�_��}�B�8X�Vd�A�p�������ϊ�o�6o:��
� EN0X�ϯ��O0_�1�`��لO�@A������,(v�]���g�c��xd	�A�q� 9(t�a�`_�l��(2R@��|���ͫ�n.��0�%K�@��*�*#�A �6���M(Y��f޺��x<��O���07>��/I�jE6`!�AI�>�{~����_S]����ݰ��v|�X �JjEF`AHx��C�����Y-��Nթ�`�Sdl}W,2��/��S�_+$mz9h�>�=�yl�<����+��&�dġ�0j�onI��@E�ai���r�Ҧ�����kW.�l�E�ǽ�B�8Xd�V�e��D��E6`!�\s-�*\Ν|tҼ�G%��@�0T�V}�K*P+2R+H�;�s����t�]��5;_�ig� ,H�$i�0*��g~�pnjE6ja��0}�A��ݯ��\j�G��>_��;��!�XtpƮN[�uyBjE�j��m��jϵ<)8���$���>������Ca��� �c;�����=4�*��OW�-V��uz�7<���E�jI���!<�4fǛrۥ�k��r��9}�< ��A���CjEFja����}������oÿ/����_N �. 0Ե�`�Z�X��z��$nJ;����[��ږ�����ofø����za�>C-C9�\�,�g|4%���)�P��KK��N�23!r��>u�CEp�s�׷��g���(}aH*��V��f6�C@
d�
����@����O�kw�E�(��:���a�� ,,JPT�"�0HW��z���[��RM��<ġ�"#� i���z����7X(��u��e��&q}�Z�Ԋ��B(�bY�ί��yk�?`�,���<	�vD
u����i��v $m�'�
��0T���;����?T�1�,�
�0�4�\Z��~y����FًD*��V�[�֙kR/ ��� ���2���f���V7��P<��DZ�� �`X��Y� 'o���X��E��a������lV콶���GS�+|�CjEFPAҦ��������PG�`TxC�-�b���؜R�x��jEF`!�[���Y�98����%T��,�������z��j���F+x���?��|��|�I�ـ��7���"8T����������E(e��{��7vk�Xǣ.��
�E��
:�P�Z�T��M.��~:�[�!��������w�#3��[up��� ��r��whg�K�YBaj�]��Uݨ��PKӦ]1�=O� iS�����8����%XI,lpr��E���'X�V��е�yh��C�YBjE6Pa��_�����W�Q��*P+�8�ۑ���G���
���mP�z�%��5�c��,P+bt�Z����PG�`A$���^��8��l�x��dO3��Di��%98�}�*�d.a��@��~ਝN�yBa`�C�N7�:�Ԋl�����p�(x�	B
ۣg�fEc98�},ȯ�9��v� �W�X	���`!a{t5ah%&��͡�,�"�0��Yr�wN���C���÷���&
��bh�H��������,��0��SN^b���\�D{;/��;��G��!,�M8$��͡�,�"��l���S�Ї�;���1����,�����C,� ������%X�Vd-)8zm}X@���K�oL�6�C*P+��
6��'���M��Pm��So�Q;�w��*G�b��C,P+�������*"��ds+7u'c��7�����C��n� ��?�r�����%X!b�/$F�S��y9�m�֋[}�C.����#�����Sͽ�,�"���M��՘�mNm�����������^���0T�v���K��T���
�
�
��CC�$λ.f�{L.݀a�� ��^�k�� $m��s1�s�|��uc$�e� �s��	8}?�?���R��*"����C�����C��$V�_�9 �1��9R�?�H9����,�!2jd0�$�v�w	**�h����bﵽ֜�����w�C�]�0 ��,�"���M�6C(c����K�B��:�Et,V0�ϭ�����!(e׃��cͽ�,����bT�� Mn`aS<�^-'����Q>�߻F�(s]�@)w ��?`A�f�|��u��EN�͹@��pT��bb.kzl,�~�Ι��r�ˑr����%TA�@�@�pQL� �����V�q��r>�܁@��Y�a��,P+��u�������+޲/&��x� RN5�r��
Ԋl�\E��b�h������x���[�G5�Vch�K�r��g	�ـP�*H��V����r;�]@���}[�T<�k�� $m�N�Y`�,P+�x�g����K��Q���EY���a@��YBa�
r+F遅<fg�b�[틆-�h\�r����%X, �Q���*l�Q����=�Ҩx,SIWE#w���P�Z�T���3Bn�T��!��:���>��,���//W���r����%X�Vd�V ���kW��}��Q��\�е��I�!�(C�X��^��e1+�k�CE�j��L�2�G!]o��g	�AP+ȭ5��0a	8-�ߖ!��cv:<|�'K� X ��j�X�:�Ls5c����:��vVK�JG�P�Z�T���3�Z!�A�V=��	@�iY�9��u�4���b0�}Y�jE6`An`�KQ�_�Z!�Pa`����D��x $m�N�Y`�,z9{��L�2�Cj�T����
�p��jB-YBa�
r+Fͭ BD��"�X��um�<�� �`1*X�VȀ�:�k�0Tt�H�E[y�o7��"YBjE6PAҦ�j�T�+>�T'��,P+�r+ �^��y,��Z!'^Ԯ��
I`X!bK�*�H�6�� d9u�G��Xd������Xs'\�-�X�t�1׵�����'x Y@�@PT8%�
C���� ��w�5�X �A��'�aS,��"6筵���|.m���]q��S;x@PT�
�a6���`����P�Z�m��6���E�����bz\���J�E: ��,z�'l*��y�6�Q3��B��l��.��No��7�Z����,H�$��� ��'p�����������U-t�Y.��P�T��	T $m:�[<�mu��:�v	e�}k/��)W�u�X脋^_*�a+���8bs�Z�+��/�ߔ��-��^-:�⑲��7�B'T��IҦ�� ��i+�P+�3��fp(��6q��m�a��|�&�����\`�,P+d�B�s�9o���B��l�rr�`Ч��Pa����֕Km�G��>T߀
�P�Z!l8&�;X��h��A�:|�$��r�)�X��
�@�a�`�
��`�,\�e�x��a@�o�`�1$m���	��clP1T����;��9�t�1�T�
� 2jaԊa�K�����>�q�Sr���<���	�
�mZ��y�
�
O��0�L��	8X؎�������>�	� :���B]^H���j�勜k�!��	6�p=?;���؍< �`�Z!ꜳ�i�mm�
�
�� `�6X� d~=/����
c�z ��7�!�	(2`T�
�0���W	�A��:��0��ZA�&I��`�,�� T9���)��N��V$�2me�V�Vx��AP+\�q�|M( U��G'��X �X �`���������V��ON7���ގަ0H�*�
O�@��Q+H��	�r+l@ v�_��j[��_] c�`!�_�l�����S������6�uY��:̹��M�03[�t�)�X j���*ѴEz�?T� �`au�N\c=��<���
��������6pI�����PfM��]L}���=��$�,�b@��)�ټ0+������t<P=J�*�1TY�W�_�	���S���B��6��L˥�����XY�#��@�@��KlL. �BX(��
:*����体G�H< �"e�H�ч�P�*��>+Ħ,y�,���N� , 5`��h���|S���	j�Љ��+]��v�*� *�
5PAҦʄM֭�	U�h�`T��Ql�<�X )�E�
BȾ�V脋,��(#�Eg�h���������� ��	�|S�� ,�@P!
.j����*x��{�*̴U�����}Ⱦ:���M�ʅ��N�������*x���"����6��&X�5
I���T�A���yq�G����*H�$i�w�Ms+m�@a��a	�h+�vz[���d3�c0�� ,<�������B��	.ـĺX$M���gm���mq��q�ʥ��� *<������#�`�b��젢���͌�÷�� ,<�"e!d߀
�PA�&I�C�'�.�(\��ϊ���4��B�P����S����G�S&���	j�6I�|���$��C���UVY;����|^\=�*̞p�+�������PAD6�
�P�Z�Z!��5��	��aX��uШ��L�5ᕋO/�����< !�D,B�
R���	���F�l�\a���T4��2tL���w��x :��BF�`o�P�ZTH:p�e�C��A���us~S쾲��rT��x :�"e!d�P+ U��A��U�@��A������BG-x ��AD��X��N�P��C&nY�E�j�XخYV8���Fr)�Q�PAD&T�
� �A4�.$�X��6��m��0X��\`�,P+ I'��,q��[aS"B����#I�C*P+d�
�6uBjP�$�$��6C�C���a�HYA�7�
�B�2BnE�P��"c��/t�u<&[�b����[�+�I����f���*gO���j��_�9�X��+���������@�ٍ��㳍�-ょ0T�	��V�V��
Ԋ>J�E��;֡�忧�S���9�`2T�r]��N�P��Q+P+b���F�p����|u�<L�3|Cj��ZAҦN� i�����#�!�6E�b(�����tZa�HYA�7�
�B�2B�0�o�B,l 0��&��ݝ�i����t�)�X�UΞ0a� "N�'�2�=c��s�Y�kj�������7�`��L� �A�xLCE��?Ύ}�<����4��ff�콶�I\HG�R]��LK�,P+ ��#X ��b��
'�XO����Փ+��R#���},t�K�`An���$m�@E�`a��W�Վ��is�B'TA�@�@��WT��l�`c�|�Y-��`�,�T+Lr(����bADD���#�b�0H��]���6���C24�,�`�anj�^�H]E�?֮й|w�E�P��?�֑{�GHXp�K=T��Yd�\�V�V�V���!Ԋ���d� D�k��Ӻ���u�aU�,B}ͧ^jjE/�I\��ս��P�*�,H��U����هʳ *�Ԑ:��X����X�U
+m��&+m���
]�,��H(.e\}���G����,H��'�By��TI]E�?� �A��BL�p��k��y1=�n$�ւ��F� `X(�P�7�z���)�"����1� j��&7�7�K����0����ԝ}���C+m�@ESL�h�������j����M�PAD.$�"`�Z!���*�ݧ�:�jY��)Ԓ!X�V �����,t�W �El��<2�
�
�b,g�^q� "�VD!�"�0HH�q�N[]����Y*��3��(	�xS�G,���jjEHg��?���m�:|��j�:���6K�ه�8T�V�@EjI��=�H�����ΗwVf�l��f��,P+�YC,P+D���"���>8�9w{WL�'�ౘ�2B~G�P�Z�lf�t]�2���"��Y_h�{���]1;������c��,P+P+|w1%"�VD!i�0Ȉa��p�t����֤�zq�}�R�ߟ9����!��R��0SL�������� D�W��GK�dڸd�rj�PA$ug��P�Z��ZA�&P�	&� ƪc��{�˥�psar�A�0�o��M��V�de������jg�`a������� ,D �7Y� i3eP�9��ϧ@P��A�`��);����;8��|�X �`AD,���Pa�o�������N���S�ϖc�+��r< �,���M�3A��bJ�&��� ���6�p9�y�8�Y-@EPaf���jj�����~���/�BX���<jg� ��/t �`��aQ2��8����!�q:m�.�c�=����#�V��)�AȭHA�h�`�&XԂȟ�y ώV� ,���^���B,H�,R�"O�������g����#t��S�[*P+D��B*��w6`X����ٻE<Rq�c�C,P+D��B,R�⏽o�E&`��]�5�Ɲ}r�
.j��9����L�"vp �B� �kR�(׏ 6�����Ǜ�G*�}�~�Ca��0P�2T�/��R3
(X��h�B�h�����������&x��˘N;�����0�X�V )���c͹,���,�B!y�vr[����J��icp�C�Q*P+D��B*H�$i3u� ,�����!��:����
oeD��W ꎔ��c�[�?T�ԃEd!0���?�~��o���`ADD��v�f��P`����{��r��ף*L`�
m���!�AD��0�L$�/��۟���?�B'���
��o>,���ǘɥ�`�Z!��>�jjj�b���B'T�F
��s�Sl}i+x�Cj�T�VȨ$m��9��U/`�,��@��k�$�#�I���jj��Z��r
�z� �B�r�+���qJ�ʬ�&�� "�������z/`Xx�E�����Q$mF61��V��l�x�`X(��c�[�?T� � 6�?�����b����R'� *�
�âb�r���T�
MI�cC�K�G��ji��X �`X�!X�g�5�3�����0���-��Y�1 �Bf6H�a��۞����`�2�T`��o�b�G��2�&j._�H�`	o��I� )��M��B'T�+.0�]���ag���r ����~��:���ir�>�@�ĵ׻��PT r�;�r��*tBj�\�J�����^��`X ��T �`��4��@�� TyG�>�nYY@��a�PPT���)L�`�2���1�ٜN;���H,l_�w�B'T�	����5չJ`X n�5g,t�E�
BȾir��2y:y��@PT @���
�P�Z!�V����cj��,�1�� , ������_�)������������jr����X,����)I�r��b�<Rv�!���N��F����bsV�`�X �`a�
�x :��0�L$%�Z_��r�sT��mL���� ,�l,�Z��N��E�r]�9�T�SA��߻���쓳�u<j�� *<��0��aSm�
�P�Z!�V���7i���Mn��[�2RN|��o6��y7� ,t�E�
BȾ��u�b?\�����)�*��|���ѸI\�N�C�=fǛz�7p��`X�t���J�!��'wXx��p;6�b4��ۄX�����/<�;�X�gs��w��B'T�	����S�(����T�\syS���9\���j��xSo7���q,t�E��T�K�)��/y� ,���q���
t<.���;��gs����P�*P+d�
�6�O�\a��,l����M�����v��.cX��TՃ�����>���+�Pa�*`a+�����H);q�}sq�\c�����C֗�c��o�P1N�R��;Vv�5�k5:��0؁�e��
�PAD&��M���`�Z!������w����BY.N�k��X���_�)ו�s���P��Z!�׷��ۇ��icT��4ء�6F@�N�@��Q+H�$i�e*i�5r+$�A����9.>mY@Lډk+��09���N�HYAٷX��sh��bAD0���֏���¬Zz�Ӈ=ZW.�
]�8���m� �"��]W:�>�Ca	�0eԁ��oF�8��I�:�$��ч���,9�@�N� "�����fy�@�� @��������Z�pp�8:�"�W}����c�<T�VH@��Z���m����v�L�����ar�@�N�@��Q+H�$i���n{I �Pe���Q���'l4ء�e� �`��z�_�}���^ył0��b1�*�>����&�pq�\c�����C֗������PAD*���" � ����	�A��	>m��
	������/�Y0ώ��W��n�xT��Q��N��E�r]>�{��ɐ�
�
	��A���%����_����xV쿾�C�F�%W���	����`�-�R
l�S<���܏`a���8z�Ⱦ�G�j`�,RVB�-u�s����0�\�wvȡ���BE�KYf�q��}:m�j`X�t������vy� �.� ��,l�D��6���s�N�U� *tBa� )C��<X�V�@��,��(!�����ǘ�X���_��֗�s���P�Za��Y��0TH�}�<�
�P�Z�Z+0��� iS��E_(q�`�X��TՃ��rur\7����1�� ��D�u�������eC��BL��Q]p��Aq{}���`X�v�!���˘�Ca	�`�
�<	Ǯ�g����N����b
�
��s��߄*�<B:ߔ�rqr\>���B,�T+"L����sګe�� �1�|�N�ч��\�\*P+$���b`��٥}1Q��*H�$i��9�|`AҦ*eD8�b�z��G����!X���O���o�m�� ��*gO���SUc�������v��.Rv�!���s���PAD*��	$��u���<|s4����\W��7�v˃j�Xd�V����*�?�!��c9�Ҫxh������C�-u�s�ԃE�l$uled	¹��]�U��zT����<4BGH�r]1;ޔ�.�A$ &K�@�@��(���/J����~�a��Z�:Rv�!���c��o�`A�(s#|=Q+�W5��u`Q�;��<��	'��t�)���M���P�Z!$m��C(�O;����	6�0��>���}Ⱦ��c�<X�VH���׾�B��aŢ����aw��	,l�q�w�#��M��؝o��W$m����K{�����a��x�C�Q4T,��}wwW�|d��`����c�<TA��̭ i3��
$�`�*\�d>����+C9�Xˍ���vy� X }��s�W*�.`a�f>�G�5�G�pЧݩ;�X�'�PA�&I��Å8XD�Vؠ����+�m���mq���z���5���M���`�Z!$mʀE��9����A*�p�79�H�9��?�`A�&I�=�9cv�)�]*�4).@���w�jI��oZ��o�m��
� jaԊ������JE]�A�ڣ�Zr<|콶W\~~YL���Hʎ9��Ƀa	� X��2`!
�eX��X�I��_�#v�j���B*P+d���+2Z�"�Mi8���__�O�u�Ts����
	�@������cb�!X���*�, 6ٚt"�;�گ,H�$i������
�6SMS?����] ZAD*�H��AP+bW#l���
���:H���n8��G�a�/��T��[����]�`AD,� 6��yq�@��0Z��8*�cv6+��R���~7H�H*P+$��B*H�$i��*�1܋ZѬ\4)�7
���Mq����ʱ,j�xty�@�� �
����>���+�A��
��V�����8P<��(AHabh�`�#9�(uG��9���Ca�|� ���J��6:)��l��
� R�X�W,bu�9�[,2T+H��\�B��T�O����C{�<X� �,��T��T߿��c�8T�V�V�q����������C*P+$���M9������fq�@��,��A$�����W�7�=����y�@�� �
���A��G���� $m�q��_�^��`�X���bH�LnE�&��
� ���A$� Df�Y��m��<T�P+��VĪB��[,���AjB� ����[�Y� "j�H�V,\�ׅ]<K*P+��
�g1���X��/���n�!
ו� [A�yHph�K*Xi3,,t�3q�@��,P+����'W~�a�3�!���"K�`�i6�@ �6��N����Me��̋�O����><���K�@��,ġ�0H>jEa����?� y��?���H� ����M�6��b�V,���ɨ6�1`a;.~t�<r	�,b��6�CjE>P�Z�SҦ���A����L�g�$�ld	�A���]�V���*F#p��R�9��칀X,jG�PA�f6PA�f��M�����f_5@���j��uPQ�����ҏ=�K5AG�`�Z�X���&��\���ci�3,tQ/<��<������b����ZB�`�?��5��u�׸� q�B�Q�V�-&@�M�0��q���{r���%TA��ͭ i3� i3��
���6���lsF�I4mM.�
Y�a��X�L�Q�2�(�עVd�Pa@e$Ţo�[_��P;��X0��l�,��"� i�l�X�L܌%A{;��"R�p����������d��"�ϭ BD����Y��>q��X�p�k���pR<�a� 3|2�똋�E�ЁM��<jjE,���Nq�HX�p�
�k��C-| Y(�P�Z�Z�H�`6�A\x��x�\:J�E*�=#���,�������˜{6aD\� "���?��Oۡ<���U��� "�X,� �X��a��A���e�h�N�tCjExXp4q�@��*X��)�}ִ ,T��@��|!��p�a�pur\@���"�P�Jԅ@ȭ�Q*rZ+�<�<syS��0�v<�� i�wQ��"˙ �٨����B��w]����(���mq���&x,f�x@JDx%�e���
� ��Tr+d��
�6EB F]�v�!�}.ڎ۫<�p�5〇8Xd�V�=��u+��@jjE/xq�
t��7�7�ޫ{���Q= �q@by�š�"��0H6a�
�BX�����]1=�[/>���8��>���"�P� iSN����3AD� ��}�0��Z�h4]c�c~;/�>9{ܷ�(� i��
Ԋ|��"��0jE/�QmP�ߗm4�q����� � ,dv2�r6jE6`!�V��)�V����G��s��
�a����j��� �(�`�(a��"d��6�p9���6�!�A�
� @�/T�V�@jE���.
�4H\�iwZ鼇P剃jE>`�ZX��j�X�VȀ�0H�q��E܊�8T�V���@I�$m��H�6�� D9N�ӆR'��,H��N8E��,H�,R� ��X:;����|\������!�C,��X �a�p��Fg��=I��ˉ�p��޽��ԂG��
� �@a��*H���"���1��Κ\��`�Z�X�V �� �(@PB�cC� ,��Wx�'�/�����f�� 	`X�[}V��������l�
��*��@kW 6'����S{��
|dl����u�t��7�� �"`�ZXh�65�+�Z��M��R� i��B|�*�{ �Bk-��'S4ӟ׫�ic�,��0`X�
@P����.笳Z�&?��R>��
Ԋl���6Y���Ҧu�T)'�Z9.�����7NݗL�|d	�ـ�xnI�b*G/�ϢX�-�x�����L7I�`�3q3���1�"$m��PA$6P��^)(Q�޷�VT����Б%TA� �BHڔ��.ۡ�_���q��� �u�=[N>:��&�#K� X ��j�� 
�@��X�p�c�a����x���f�#� , _� "$�`��Q�t���������yQ�g�J�%	� *�
_� iS*XiS*LH$&g�S[�v�Z�7�a���b�����KMnG�X �`�Z!�2`������Z���vuczؼL���}�`�X��A��
�
�@�Ы�hw౶��r�|}�Q�h��U�"�dA,�B,P+d�"�/�����N��m;Ҷ�G/� , � "��;�� ,R��s�}���-�G�Ԯ�an8z�h5�� *|��BF ��hޔ,U�>v�֡�忽�c����:�\�2����+H���H*L��v��_�\@��5��T?�c�[�9������s�/�P�Z!$m�@I�$m� �0��K�}.ڎ���<y=U��qj�:w2E���Կ�c����5^c��<Nz��t�����8XQ, �"fh��=������"�j�*\�7���j�	�V�8T�
� 2PA�0`�,ġJ�E[]������c�PKj�����j�X�VȀ���������5^�`�*\���gnK��\�!s�e�WxCL���g����C�؇r���^ġB�Z��k����}�/�AP+�P�*�b��ه�#�B&l�ߖ*�:���x�q���� �`�dC:J��1�`QĦVt9o���h\2];<4�O*P+D���M��
��N�g��ه/q�H,�
.@�zMt�!�"`��P��{�My@�N� �*���j��j�
M��gv٘N;��X���"��K��	�B}}SO7��
Ԋ P�%��փ���q� �Z�6P+P+ ��5t!y����v��o.e�C,� �*I��n�&�XQ�X��������U3xT��8T�V�@I�$m����"tSB��8TI*l@r_L�����w���8P+D��;߁�͕E�Rw�1�/����n #�Y��<��yq�Ó��<j�ji�� B�0a�jfI�`as�����Q:t\|v���X=x ހ�Z!��k>���"tSB���ZA��qq�u�2�ar:&O'���u<�&���~ �"e��$��;���E�j��U�"!0��,���̋����7��8 �����~c&� FȲ�Et�sW�?�^i:VB-�CPT������	O�`�ZX����ߔ�Q&�r���BaY�`X�C:F��-�E��L	��@��T+��_��7���v:�,��`_�+j��w?'�ġ�0j�R��.�x��{��jQf�������T�&`� �E�`�j�����C	1�-�W8���&�P�ZT(�
q������\ڎ�ws���I,P+ E`����pqα^�YR�;� $m�I:9iS

B��<�E-`�[An�gnSLݝ|h �
� ���B/N�iG�����Β��AF,� ��*���'N�a.> ��Hj6�8T�V ��BkҦ��k;���� *<��0��zZi�
�BXhsб��.�^ڎ��wj���ݝv> ��,B;K�s���M�6uNE�!6���?��Y7�X���u�D��ѻ;��c%�AP+P+�ʭp�4x�����tL�Lt�G:�>�t���`���0`X ���2P�����l������f�}7gj�ġ��P$mʅw��6�XS+\��:�_���]1�@���A���P��z��8X�V ���E��;|�C�A�h+� ���8|��q����R����M��8�n�>�x$m��iw��Ç8X�
p�����W�v�]�s���ڿ�����!F*��V�V�[a˭�V�QE��q�ޑ:g�xxN�����=V�`A� , X(P+� Gu�Փ+'�h_ǚ�}��%����8T�V ����M��N�a	�p)ö+mu�V������ws���I,P+ E`�{N�T�š"�0�4H]���3t�v���1�I�$m�}�K9rm刃E"a)�p-�Y����ч+q� �Z�ZAn�-��Bl��U���ɀGHGI]� F,� �`a�
���
��m���m���}7gj�ġ��P$mʅw��[��5$b�s��k���x��xX(GI=� F,P+ E`�-G!���Ca�Q�
��n	��ξ��9^�I�$m�}��
�v��a�$��(���w�$�U��(��bġ�0jj���
�
�2b��ӝ�x���}�� �`X���B,����r�f���Z���)�=��8T�V ����M��a���6U��?(�U�/� >�Q<����P��λ��8TQ+R�xLX��F��ÇU�n@�� �I�$m�9ל!D,�����Spjj��x�E|��ey���c:ġ�0jj���
�
�@�����u�T`a���Ӌ�pR<rq� X ��,P+D�"�:�M�H��A�����m��G���Gj�!�@�"� iS.�C��M5#F�p�k�y���n��!���"��9B���PADD� "��rfg�b�K[v�Ъt ��6�nGʽ�A�t6Fa�<$�k�e��a�P� ��+R@0t9www��pZ��`Zj:ġ�0jEP*T�e�Cj�T�VȨ�� C��Փ+��K��q� X *᠏�"�"`�Z!C:zme�}h�>�!�@�"� i���.[��xm�`!II������_�F[��ji���
5b !�R�W+����AP+$@§�%�� �0���b!��1*]ڜ�ZaD���=���N+�:�G�`���שk�O,��p�s(A�йnj�` 	vH����I��Ҷ�ʥf�en`Q�0$���#BҦH�B,�&���3�vv2+Nr�FI	<D��S��a� B�KH!�k��I��!`(����S47�7��k{�6��	< Ԋ��&�A��a��)Rn`i۹�����i�O��`! �*C ����0a�>�sA�2�l�������i��#D�������	��CSLE���M��
� �U����/8H��4�v� ,t�Eʡ��}�
�P��>t��"����]��;��r<�!�)�T�
�
��0�� F*P+P+�S��g�!��M��U�B .��+B~ѧ\��ZADD� "J§�����k������ ��
�
Ԋ��vi�*�k(��� � �C-_K;v��k@c4 ��AP+��a� �*bɭ���/;�\�x�Eʡ��}�6E� ��}����`1ė6e���&�s[�J�0����ÄX��a� B�KH!�k�a�@���!@*fG���T���xD��!!��S�K\� iSD� i���!���259�����~�О�<�eT�C*P+P+bT ��9K����Y��e�����Pmw��.߽T�I��]tR2�� �`�i�0)`�*g���x�����C!�&:�C���%T�Vd��[iT
B�s;�-�:x��b��a� B�KH!�k�Ԋl�b��@n冂���L�&�G�/���W+H�Q+H�$iSS��m� ��oH�����w�K��F��>d����0�Xd�VA� �"�܊`��'�z-��+��K��#��M�.q�@��
�
���+X�b(�@K������T�g��6������jI���`�s	o�
�B��LX��co�
G:�����9�\�8XQ,��6	�!�)�����7+1CA߶�Ca� �Z��*�J�����y68�����G�<�C,P+D�"K���M�
�
ԊH�
��p9�WD\ǣ�b0���P�Z!�2jI�2yC('Z��coj�^��*\���#
� ,H�T���W�)SVbw�Z�X�6 9���"䲱r�ʅ8XQ,T9{�qCj� RZ�r���*L�DAҦ�6z~>/��\Ճ��W�D7.�
� "PA�0��\S��;t-��,�
��Wp���+n.n��7�kiܫ�U��
���P ��!�Xhr���z��)�ގ,��B*\�c�3)���e�$΀�8T�V�@jjE��C���,��"8X����#�&q��Ţ7\�VȀE��9��iq̱��ЙkasĹ��{u�<Z����2PA�&I��C���YBauj�$��}j�7\d�X�V ���1�~>K� �$X��IQ�����5�aT�#K�`�MV�d�MV��l�M�/���x`4�kf�쾲ۜ\��S�/K�@� , ���Y�6�h=;/&ۓ�େi�+�.�1�X�G�P�Z�T�d���Z�O��M�
wEc>����٬�V*]��u<N�=�G�.Y�jE6`��)�ގ,���MԊg���2n�����*�U�Ъ~ 23Bb���r�cw�Zڟ%X,�`h�0j��g+�gţ�0�z�%T�F� "�*P+2�
�ż�Cý<�Ac4��,�dZ��coG�`�Z�X��`<��
Ԋl��BF�0PX��I�f��!Y�jE6`�J���YBaԊ�C#�*F��z�G��X �]�i�m�`A� ,��N���m'��a�Hy6E�}���s;��
Ԋ��"���.���k���<��0T�/���.m�,P+2���&���O;��ZT@�0X��E�r�]�&�ؓ;�6I�>|� �=V�0
�P�Z�Z�:�d	�AP+ȭ�ʭ]����{�����M�6IڴM�%X ɀ�Dn���G'��U�H��!)�b�[�JB���V��ܕ��vh"d�qXo�e6���ڎ#x@F��7���p�9ԑ%X�Vd-@P�nwww�9�������W��ܥvI�hݝvn��G�N9�~���C��ЩX�VH)�N�XYm`>/.}�o��p�}�ps�#K� i�"s���<�ܓ2�c�-�#F�����c�`A��q�;NƮ��ٖK��Zbt�1�9��M��,��"#�`�M��8C;�o�+18p�mL���_�`�Z�X��T�����T�ƽZ4:um
�xS�� i3�Q����4�d���U� <ʙ;Ф��C�/K� �ZA~@�� @$�ڝV�� ݆P�7�z�� �`X`�l����?Ty�;���*P+2�
�6Q�Qbx�u�j	>��p�9ԑ%X�Vd8��m��N�s���<rp�!�X��I�f>/u8�Z�ܞܶ���D|��=!nud	�A2R+�hw"���헶W�ccV�"�����C�1K� �X���yisv����^���^G�P�Z�T�V��h;p3�T��Z�#u �Y�jEF`��y�3ebW)�@��iq�ޑ=�c(�{��I�$m�$Rt�	������0�q�A�~-+9�Áo���
� ��A$^�����Zl`6/.{i� �vwZ_���,��0HF`�C�!`���6���<�#K�@��*P+p(�;����l;�F�xd	��/4��a+؀~�sSȰ	`A�&I��_&��yF� 6�b��L��Ww[C.�I�G�PA$#��0�ˋ�kpX�@^6p��Ew�p��,��0HF`����������6`V*�����a�#K�@��*P+��`�'�`�6`�Ö�Qj�nJ>�+i�;g����S��l ��ʡ�.����Ǭ�J�
�as� 6�bi)�E@�`L� ����� 6�h���ׯ��K��y @ş����M�%6���@��.�� , ��x�1� 6����"\R��!�����Ë��`�@8���FإU�x�(�
�6%a����ce�l ������/m��G{�Ep�XH�?^�� 6�`al���֋[��� *x	�y	0Ό36�ef��0�a��˛n�8 �b(C�\^�� 6��o8*ظ��e�����)��| @?���<�6��e8n�o����˥��Q+x���	��G1֏�z�=l ���������}7� <D�0��al�l �4���̕�e�Q<����l����l`\�}0s
��x<BǸ��`� 6��x�\�F~Ɯ�1�l���6�<�I(�?��@xF� 6�`9���W[	���5Gc���=6�`�����u�b�G����g�`� 6���@+x�ρ1b�� 6�`�@�6p�עxTI �?�t\0C�Ր�7��`� 6�b���^-�7�%|0��6�`� 6����Փ+7�x��WĽ�6�`� 6���̋ӟ����� ��76�`؀��M�n.n
�Km�Z�K�C��6�`� 6������}qsyS�qи�:��As�����b� 6��fo6C�u��������l ���@�δ��<��v�p����l ���������`� 6���@�&q���3��)6�`�@�6`ݝ6�����l ��y�~i�}]~�S���l W�}e�����o^|� 6�`�m��x0��m�ԇ�a� 6���}h_2H� x�<[l ����6p���r���86�`�@�6p���&q9}��`� 6������ڕ�Zl��f<Ol ����m �`S8�y��l �����{�+y��G�DF��*��l ����e���z�Q/?�a~Ќ+�`�m`���< ���l ���7�-��6��i'p��W"6�`��|^��f�Փ�bySf� �6�`� 6 n��i���n�[~��?\�{���Xm�n�8�d��xTY��v�v���l �t�����|��`� 6��� ��Q�_:�*x<l �h�?�ܧ�P0�`� 6�`��@��A����48m�����p6 x @6�`� 6�v��0���	4�k���l U��h�:�>\�ŋ��l@���[��@rC���l �����i׉D#5�&h��l �����ts����ӓ�O% �'>���̰l �������n���WW��zl��l����������:�C�l ��l���=<|����a� 6�`�l��w�`p�.��xa� 6�`�6p����Q�b��l �����o/�-��1Ό36�`���|^�g���ꦸ�����������&�`���6p3/���쓳����8f36�`� 6����d{��OK�tZ�
����l ����v_�<�A����l ���@ݚ`���`�<ƙq��l H�n޸qW<X*�A�?��]c� 6��T��%�y@a��xc� 6��d��e <�R5��*Ƙ1��l K�O7�-�?�,)}Q����l@�L;���N�.~`� 6�`�@6p�mW<x�q<L��	��l@�X�C{h?2l ��l ���+��\�x`�q,ω�`�@�60;�G�����Î�a��xv� 6�`c��ệ���^-�haF6�`� 6 nM˥����M��ϗ6�`�� �` � 6�`�@P�I�8>-�x� 6�`�ۀ�^-�w���C��l ����:|l,�����x<l ����m`�+;+3\V�#���~~�� 6�`؀.��̊�/<}���d���F�t�x<l ���b~3/n�n��Wv7�c��q�8vl ��l ���/�r�fgڃ���L<�^l ��l �ctL�&��K�TĽ*6�`� 6���@G�ʥNކ����c� 6�x�@��1�iV:�i��i�><�&�5��)�l ��l��N?<m�4�Gu��b� 6�`�@Whۧ�q�8�C�jh\��`� 6� <�ÐD�l ����6�ywZ��/l ��l��tڝ�����b?� 6�`Ma��Y-@����l ����?ܜ�x���0d����`�@60;�[/n5�N�����PyN<'l ���6p����Z�W���.l����l�l���};x�p�{�<3�6�`؀6���֮��㡭���6�`� 6����t��fYY�������̰l ����ͼ8��qӕY-�όf�`� 6�`�؀Q;&O�w�ݘN|@�� 6�`� 6�k������:�t4$��#�>^�� 6���6�, l ��l ��y�x�tz8:��kl ���Tl`�3�@R����l ���-�9(�?��1��l H���#���O�ȱl ����m�	>��B��4l ��l@��^=j_2��L���x��⦸�����ɕ�`i�7���c�����O�����R������b�����0CaGl ��	0��l��eߝv]�h��\��z�zp�ae]GP/�Đ����a�N~xR������&a8����l��.~u�x4�%���t�г��L����~��eP��{�������w����������/m�_m���:]��^����,��/�}�hQ��;��ệ�� �gMy���l`��^%u�I�i f�/���?x���q�M�M?�*7��7Ϝc���4P1ݙ6B��}1U�QB�18ے��m.�_�J���f�� ��g�������y��U�X[�A	J�T\��bpU�n煱ec�g(��xN�����ϝǱھ������'���ߗ��1p�����h��9�Zz�G��ON3��y��8�����������7��{�7�����Q���>^ݙ���@�n�(�R�M�����<����r2�yy��Y��4�>��Ԙ�����ۇ 1�l^��ʊͩ/�t��:o.oꁑ|N>:y��5�<Lg?�u ��:e��f���Ng�Kݵ��OV��r4�et���2i���ʱ6a1�0c~��˕�;j���W��4D���}/?�E`lq��f�nyc�7�7�dk���'�ɢ|���g����~���V�<��[]��]LK(���X(�e�M{]�i�3�\��z��RN�k+gb~�7�7���ZW�{��)C�K�h�aQ�Vڶ��i�뻃�m�U� 69���X���V\��v�q�f�Q�m~�VV��e���	���K���w;ٞ,������Լ�~��c��xsu� ⥯<�@��]~\��t��|�u����8��XZ� �9`���!���7�wɓ�1��ۇ헶[�`iJ)�4ߺ:����R^���MU�B�����מ|��cZ�mBN�Ps����Nԡ�u/d�B1α���������0vk@`�dRܜ�N����1;.����0�2/'c�;��3���¨J����ksW�r��ŗo9�&�ۼ�>�� ��K[5��yo������B��������is��2�������9~p{����gg�ޫϡ��uw�`���*�Q,͘-��w��e��i�qN]~����Fe#��_]A��9����q��¥M� R�F��5�\؊��,�j>4�Xg:;��:`��N��p��Ӷq3���[��㻠��B5^�1��������Ε��Ϣ)A�O��y�w�Wg�p)t���1T}���1�=����~�J����G	���k�ȼ�a~�?z��X���Ҟ�S��8P�~G[�V���V���~���-�q|�<����)��r���x�^7�0�8r�0N><)����u_v�o�����i�	�G���^�{�b6��`*;0����3w}�m��2�g	e������mu��t�^��\@��P�t����z���k>BD.�~��'3^F}]� ����������3�a�d~G�y�>�gl~���K]暫�B���B1�9����l/`���*�B�+�r��헷�i��rm��n������9�~�|���b���V�w����"<[>�E�~r��g�3��1R�i �\ch��2���Af~��s1Q��_vW������%Ӵ/x������!消��f^̗��\��_� ����
3_D��7$o������＼SL~]�1_�pP����WhH5�n��s1?�K|��{�\ӯ��녊`�i���>{�湚g9y:Y(��_~5Gf�N=0e=}aSŹy�<?ƳoRƶ���PC\�d^b���P�˽��1/g~2�O���I�6p��_.����Z[����:�P\��s��]g����B*?*�meէ<�{��+N��09%��v�4M��\7��Vט���0N{�� �2�e`����3ƵF�4����:\��*�fޙ�}kޑ&�o��ؓk ��P��|U-b�_�F�1_�FN^H����w�_e�'�u�̐�q���d{q�n��>[���~�|�3�r�ϱ���s��gΟ~��̻�v��o~ė?ts�.u�^SC���z������.�7��(:����f�XA�l�K���V�I���M�&T]��cމ4��%���^��l ?��<���eиf���b��lc����El�v�Ǳ1iF}U��_�2u)�x���w�q7�-�zJ�-�x���QR����13�&/�$,ƪ$`'a�$�q��AB�@�	�    IEND�B`� �  <   �� C A N C E L - B T N . P N G         0           �PNG

   IHDR         ��a   sRGB ���   gAMA  ���a    cHRM  z&  ��  �   ��  u0  �`  :�  p��Q<   tEXtSoftware Paint.NET v3.10r�%�  (IDAT8O��]HSa�Ot�����N�5�*lT��/d�]:
��@T0CF�1�'��Y4�0Ԅ dY^A�TJ����b�آ�ՍW����3��	z����������븲��L�zQK�'^�1Һ�;S��q�44�ɎDw���9v�	i�4>��̖��l8`J2Ef��!w_A�z����l�JV>���~�'�le�%C���ٶ�n�Cf`�:l�l(A����i�����\5喐�2��S����+�.��T�{ߣ!�k�`.7i3��X:وtw�*k�DM�z,��[���v0��U,|
���N���d�~�δ\*t�&�Q�b5��G���"_徿���>��js�ۢ�׻v/�w�)�l��3���r1Ѳ0�׃�
����^�x@n��Qi	?���M�KE_��N0����� 7�]��VŜ^6:0����3'�<[�ި7���M��nS�BT����E��I�Ř[9�JncD�F�l��l��绍ag�.,k�.��	��1����{yLPo�.�2��|��@�y1D$	���abs������hy    IEND�B`�  �  H   �� C A N C E L - B T N - H O V E R . P N G         0           �PNG

   IHDR         ��a   sRGB ���   gAMA  ���a    cHRM  z&  ��  �   ��  u0  �`  :�  p��Q<   tEXtSoftware Paint.NET v3.10r�%�  ,IDAT8O��]HSaǏ0� �B�UW7ͥ�؁i�4�IQB�Ef�Ae!])���c}Pd�eX�tL���iw1+S�J��z߳������<���=�=��MS���Uk�z�C��大�g�vZ0\�B�~��V9�}1���S��]�����n��a����z:X�^��S���'`V �x��N������#O7#���!^�����3p��+-��'��h���b��I_��ٚ-0zn41�v�z������>�B��X����<\o����Ѳ��4��sHV�(�_��t���7$.������d�9�x�"�r.������Cd-�c?�d�q�x�3��-��mG�I���z�2\d^
����:M���v��߯�:\%A�i^����m��Vk��>;H�D�7����F�ruݚ�W�r���<d�{��v��<U-�d�c-C���Yx�ktOU[��P�_��� ����؟g�y�6�u��o{SK��lU�ޔ��a���Ң2S�2�S�K}X�m*�D�Y�"<��F������7]�����R��s������oVh���    IEND�B`�  �  <   �� D O G G Y - P I C S . P N G         0           �PNG

   IHDR   �   i   �W�H   sRGB ���   gAMA  ���a    cHRM  z&  ��  �   ��  u0  �`  :�  p��Q<   	pHYs  �  ��~vx   tEXtTitle HugeCloud@��   tEXtSoftware Paint.NET v3.10r�%�  �IDATx^�{�gUuǱu* ���#&� H&��W��j�hL�����X�Z�@��4N��PJ�&�b�tRLj�(�	����Tۦ�����L���^'���~��;?�~7Y���s�>��������)G�6]<��C'��D�D��������N;����u����T�â#	�O�Θ����6e��(�ú���oʏ[7z�^)�A(H���~�7�kڔ= ���+� ��E'o�\7:�b����'z�詹���
PPMT�:x籢g��[�m�@�;�J��'�/��?�,�L]o(H�D/̔��]'�E�5�k7Pw���a�1bԟ%�a��+�r��U��k���oI�}�������ٯ�9��{@�J���w��	��?��Ո�)���3?�}���<��JQV�m�.|r4M�9T����#b�	���R��������E��(�Ϻv�7�W�9����_�s�N��s3L����(g�Z.��t�&��'~�Ř�� ���h�����9{��P�N�g1�����[���)����@w��O�R���1��9&~_�mKH����S�"�\\�o�����Ė �#�mt���օ�S~BT�5<_��X^��7e�E@9Kϕ��{t?�p�-	⁂d��i|�O�bv�6� $��To����ψ�p��]����'��	��Vxj�u�9�z�H Ń��2�PU�_��
��G���1G���3��n�ǎ;�|����b#�#~��Bt��|�sS*Dװk����xY�o���$1P\l��n�'=s�f�e�]f���a�A��X�5I}�5w��2�;�Lt  �+@�^��4իF���#t�`D5�'�YF_��:���3>�@l�j�/7L}U��s��'���Ν�k��Ǧ�7�E��)����;��c���%�pg�n�58���][+��uc�Arz@v��S�Y�w׮��$��#��%Jh'�v���L:�P�Q��Ϫ�ԋX:����T��I:d�2���0fj?�$A�t���Ŷ��/�p@�#�SQ21Iן*��I/��>{/�������X����#�Xg$��v����J���n��l��$`����F���Y��^t�7|�#_|����2R�x�D���Ӟ=��_muA;��-�V���
���m���p��M�V���xL��4��0��g�*�æ�ۍ�ƚ��e��Q!� S�~����[�W���={�?r�������f�U�w QXPA���8�"�_-Z�.��M/�L�s�˱��l�(�패<r�X&����G�?~��1{�3�G���G�����}���8��y��p�#o|��Gd���oI��ߕ��������T�M�� f�/�����|��*���]��P�=�@�������7L����:��� �N���Cܨ�{����z�;o�Y���o��F�`���� �� ��<���/*s��4SEM�:ŏ*߁�:o��}��AT��@��&���h�����߂���� �v�F%�TϤz�/��o��껿u��_�k'E|Iz�z������Ԍ���>�ِ�}��ӢW4&�c�t��N���fI�7F��N�^��~�Ǒ�N���$P/=� �,����=�+�Z�t���}?�B�0�����@���z�] ÓI��^�l�E$9��M�s/G���ё�Q��R��9 �p׆�X��� ��Kԋ������ɻ[�ޠr�G.��s@QY����̿��:i�ti �o���Y�d<όf���M^O���?gl\[[L-�����˼z�^�4s�OSpݫ���X�^1���,S�:��}2��  �y:cCNʯMK$F��(�F�vN$�����m@��@Y�-tA"F�3����
���CH<�2���|���ʝ$���7��ab��C�s�rP��[��X�O̌�����oP-�n�LcLo;�g�_T7ң�E�aT��D�J�s�+��Z�KM�a0|���*�� ��D�7�%5�p�N�3G�Y���(w10ۗ7��35�U[	��H��7�JD5���zxs�+fl}�$UP'֞����w@�P�+j�ݟ`�� �@�Q<U�x,������=.o[�v��H�PO,�����x��}2K�b6��,�$�<P�%z������.ж�ЖύJ*����~����4Iz-��ܻ��*$�65��*}�nr�b���E��`1w�v��u� ���x��)I������o5΋��bg���hS�<��G�#��A�6������Wv�oPZ�#	�3� �!P���%|�~��O!��,x~0(ޅ5k��`X$M�fK##�rA�$��3L����N�����x}R��^x���JS��]wOj1ײ ��?l�A���ף��- �I��FF�Mh�3�V����@M��VQ� B��D�u) 6���P���O|�ी��s��a}�\��빣��>r�Z(�@�d�.!�ǂ����H�x�Ex}��f�W�'��"����>��{��m�ޯ2�u�i��Ǵ$�.o��ͦhl$I��j	��J;pҮi�) 8�����	�:lU���d՟q����!@9��}�U�-�q0f1�{I0���{j+P,�^u���л�-�����~7��]�f�Fe��ۚ���Y���w��5{�E���Ob&�$Ioi	 ��@�J��S!E�N�j3е��T����FI#��JwQ��~���*6��sF�������;�{n��������� ��(�'�kU_v����uL��~��w`�����]$&�|��o(�[���I�Y�uak��*C���L@ٯzƥ8�0`^����a����q�>kP�~]jn�;���Ke�������Ԝ�ib�Ii�_���Z��g��7�H�lS7�Ɣ.�0�a�b$�$@�}�㣡���k�5Hbj�7�f�PO
 �fR9��i(A��^o�[۞�f1�Q��e&"�?aǧ3E'4�iF7ǣˤG��M/K<������h��c���r߳0щ�r��A�yf�z��R�6bP?���b3�D?'*�>��e�I�81bf�*���6����nH�&���`v�o����I/��d���HL�V�6ʊ�l����Ҧ:w��{DD�ǩ'����Q�u��qߩ�ni����۶�)H8W��;��H�5�|������/��+b���d����6�3n���Nd�8v���H����^��m´s�u�TNSb�f�φhk$��I��1
)DP0N���^�9�I�~v�{636r#��f�Ul$�} o��a��'����6�F�Ũ�I''z��m�Y�򻢕mz��&#��h0��~�ؽl���a[���������0~���c|�0s?���Rg��4��P������^�I���j��V��]���Ǭ^��YM�!�&�؃��U5�y&&ޓ�`{x����ә��X�����V�w�y����D����-�UP`��˘��XQ�������"E���[��M�o1���A���PE�Zu+��b���MK�r���4{���W�@�Al̒��b���"�C�Z] '�8��4S�1g���k��9{ ���/I�ٽG�s��呺��\�p�ELTq\Ǧq|Z�~�s~����= F1G@�;>/U���P��d����fʿLe��4V��{Y�=3�W�%= &�T�O��@嘱��G]{����	���k�ʲ���1j�,��z�{ ��+�;V% ������ɮ�4o�:�jw�,;��r����ͳ��?w6P���R�Y���(��p��9!*��*�*;4w׸��m��O���W샔���9;bx���p^��=[�1h5���9;=���ߜm��u�q[E�9�#��ϒq�pX���Mq�Y)#��p�M��G��lϦ�K���ะ�(�8
��r��ݺ��s��m}�A�Po�S���I��a���)�zB�SNq\X(��/_��S�K ^w���;��5��}l����Z���U�®Ԓ��\��Ok��ω)��RR�c���eKF~&.�!+퓳ĺ�� �<xX�0��Z:=H�x�M z��2���0��O�q#=���~+�GL�ᘰ�H'(���5T�9���f�%]GbՎ�������;�S��;� �:C�[���J��)J��XBm�\�D�TWF��E�1a%�|@�a^iQ9_�{�t���Hed,�S��j�'���g�ʯC�����x���!�����V��?�8��� �w���%�` 1)�UQ줴�_˞����n[:����r�6mPNqLXiό�20����C�M��P}c$�y1}2�S3~ѸϤ���ۙ�}��yN��l!�5jM�2��l�D�nȋAǈ�܎ǔq�X��ձ��'E�ARu�F!���Ψώ@;���8m�Mb���E���"�R�!��Z��ʲ�{���l�����0I�1a���8)�sS��`ǎq�[.����"R a�o���H��d��%"�������!�P[�e{��aj[��u��QS�A���H�j�/��-�u��=V헾�bau�c�[�]d��N��7�Ǎq?��(wH�ˢ�W��ȇa��6��XR:P;-�IH��M��{{��Z�g�КmFuS;�ol��h�61��� Ǉ��S7[���K�7�⹰O�[ט��l�K�|[3<z�L(Fr`Ҥ�`��<�tI���Kxw�$�f���Ek�&9�Ѩl�c���3,�n�|_�n	@m^(椈�(L�׾���'��x�⢯�t;�hȆgB�d/kKM<�{�:٪�ǂ��zλ�㥉� �c5<Ǌ�=$<��語�X�Z�N�[t�����i: !�ql����XT]� h��gp���b# x�I� �ovV<��Ӥ	�BDt��+�2�>�w�ԉ�������%Ǽ��S�+z*0�:�)*��N��jX��U���N�t@fg��c�(>p�{����Top��
��6M�)�� ���	�ƺno $�D�s�����["��Eq5Z���N���-Pj����7����N��U��wT� ��-3l�, �����$��c�J�(-���AR� ��� ��3K �9�F�Ajrl��"�Y�&��Q��^/ն�By����ҁ�}��w1���C�)`(��8��"��������MJ4
-�b.�5�FZrD���?�n���^����e�w1�H2&�X �����ɍ�]b"�67H�7���B���Mv}˻�޾z"P�����a�1�&ͽ/bL6xWI�Ŷ���
�k��j����_��)1��52����3�:��o����g'-K0�ب�Gxd�����H2&� �ؤ���:>�
&.ԙJN�՘��?-OX���
���z����� ���^�:�bt��<��.����V��>ɩ�8ղ�j��P� ��݀��&1�%�����g �E(,m�p��/5Ih�un?���p3 m/���x7I�\o��hF�H�Y@n�,�S��I�l;G��)`�@~E 
���: 	Ǧ���� 5�g��P�{�TY6R�xO�-��g�ls`<��3���R[�Ucn龪� �++@�4�Kk�gF�IK3�����N�DÁ 9"S��d��U��`�l� A�i���1,_���+>. �I�T�u��h��Q=�RQ�L�vrF�WM��Z�����T����\St��z._!P�\��B.
�3�K��0M@����g�#1[�ƶ0��%��P��S44&�ڤ���L7b�]bЩ�+Ǚ�F��f]k��B�=�|k�-�����k϶�wj�4#�if�O�6�p�9���������-I&�5�FPSW��k��:�M�jJ��@���!�4"#}e	���(zaK#�8�N���URE��}��+ip�RǰYD�^��p��fJ0��~�<!xt��,��F�b��aS��!�v��	Qkby���Nm1��%,U#�"�I��l�悍��J��E�v�`!�&�GS���1fK�������2f��AZ�s�Z*���g*6�4�����ki���@���`�)�1��3�m�����t�\�8Cv���l��x�w��d"�}A�]x���sa �����0>�ղ���-]_>�Rb���9^l��%hX�<��	��X6����
�9���f��0���Ȯ�+u �}C RR���i���~��/5	��B:�{D;�SI ��=�-��j`�����R�I0�ɸRĢ�>��ꬺ��F�8&���R�S6r��|skG���d6��C"��.8���{��8�l҂�Z#��6`��Ϙ�����TG/�kmu*cA���F��藯Ve����4�k�ڷ)�;d�%4�`R�)*�r����y5����
�H��i��B�7�Y�w��_A)b@_���>^W��u�{`��X����=��u�{ਣ�Q(�rQ���    IEND�B`�  W=  4   �� D O G S - 1 . J P G         0           ���� JFIF  ` `  �� fExif  II*         >       F   (       1    N       `      `      Paint.NET v3.10 �� C 		
 $.' ",#(7),01444'9=82<.342�� C			2!!22222222222222222222222222222222222222222222222222��  �," ��           	
�� �   } !1AQa"q2���#B��R��$3br�	
%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������        	
�� �  w !1AQaq"2�B����	#3R�br�
$4�%�&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������   ? ��X�(�����?�9�6��>H�oo)�½�x����������x��p� ��� �k�a)����񴝊��Wm�HZ��f#���} j���K�K4��� �4�Uz��!���7��?c�7�������� ��j�p4MW����I�O���� ?֔x��� �+����_T��'����Gˠj�� ׹?֗�/\f�OjDz�85����Y��� �Q��|H��� �S��"��<�t�O_����J�q���2��^���Vy� ��3��3�Z�3M�B������RG�G�� ��8���O/����NR9C*�{d׫��R��)�F��j]-R)S��g�-~SG��{���x���6��J���wY���(����f�F������_�R}�$p�����:u���ZQ� 
� Ň�\���� ���{� ?�~K�����%�?«�R�.DpG�ߋX� ǭ��jZo�+_g�k\g�~W�k��u���K��>�y� ?s�T{]�ٮǟ� µ�VO�%�����4��u��Ǎ�k��m�� ���>�u� ?S�T��.�PH�|�G�4���KķO6Ì�r	�]�N����2K(8-S��V�v ��*�%r�[8�%�<Cwwi�G%��;\��(�NG �d��T�:T_���z#�S1+�1�OΡ�ּ��1��`�Ӿ���7��/ÿ��iѮz�-���#�9F8�}~���W�@�)�C��*O�@�����O�cR��T�wG�����$�����U���6�N}�W�ij#�_�� �� ���SR�����?���ey"x��9�8��Je�E� 
� ������^������� �i�cQ����k���ȏ>�*�?��q�xK�(H:5��k�Ƴ�w��1K��~?�#���g�¤�涄��/G��o�� d�q�:e�>��W��r�����jׯA�C� |��P�Tx3���ser�F��et6��� \�}� 	��1��� ��>"���o�*��r��]� �����x��������	����JNLP��Ɲ�Yл���o� ��i���u��� ���5�Ce�F��뛇���͍����1�s3���'֣�=�N��B�u����җ�ONo���+���bl��SR��0mSq<d�O��a{h�����?���� ���Z� ��?H�� ��ȵf�/���Dm�c���1��R����'I'�,Z�ʵ��(����YMZ��maBJ�$� :�n��ץEB q$L�����]�����.���1b9"���7�h�kTH-�(�08U\^{��X{�[M6o)dRKg��]���4
W�Cї��:���y�&v�}��P���/�|Syd-t�r�B�^�27g�����^�$����\e֜�q���Ua�FA��i�[���Pr�x�ֲ��i��d�^0OC\��rt�YͻH���� ��mY]��jJ����R�$� dڤ����T.S�ۧ[)G8�� P���,�� ǿ����Yy����� p#���X�'c�U]�t������ #��'=J�9ǵs�l@�g�Q����8�+7�%Um��D|xÏ���?ƚ�>h�N�'� I���8�� \�c���/�~��n�s�Ix�D��$ ��9���-Y�I�t�k7/n��-�ƥao�����v�گ��d5��8���a��Č�ߵq?4��N�'��eP}x�S���+��-�`Y۳Bz0�&�f(��<��3���?��$��=�,9���z~8�T�����4l�2�c��S�q����c�����4�u���� �P9ǯQW��Q�_�9�褨�RE�x����;�Ishp�����[>�h� ��'����� >�G� X� �͞��0���#Cq�� p������ӳGV~"�:s`��*��պi�~C�k��M�	QRG�F1�T��^�������� ����㈟��G�p�:�눏n*�U���$���-پ�� 
�'��s� �~U�</Y�;�Us�� ���?��%!����k(�!c��S%f=�z�&.s������� 
��Ɩ�H^I�A�H^��� �'�zj�lEo!��lz�q�b�31Ң�Ӹ�)�18'���a�}��R@�fu63^M��Y$.�1�������=��ߌ���́���q�4�"�w,�[8��E��I#F"1��W�*d�����;U7�i#��� p*�9n���9���O[��K-�L�܇����E.��5��� �q�R�#��M=��i�jđ�\(��
I��==k���l�#�}式�H��3����}K�SСNR�����<2��Yw��\OZ5ᵸ>T�����I��)g�A?9�� s�q���?_J��吩��ǌʵ�dk����Rv���>s��?x����+[��a��=+ϼ-���$�^ɿo
���t�Z?)�m�'
ó��k)F*�k�Z�u�9@!��=�s��1���a�;���*�C�c�!��dRϼG܌�	�{Vv����I2b�<v'��~��KMͭ^��:S?ݐ|�:s�¸�Wj����w�l�i��x����k;S�lm?z,%d �*�G�ⱔ�G=j.R��9bC�{�Ue�i����B�f{��Ρ��6
Xa�{ޭZ��FXM��<=��(٦�ôӹ��l�ַ2��9��q^��8�-��3�H~l��z���uU�Kƞ��%�.�u�9��^�خ�J��t{Wzi�V��ײ��@]�zdUi,���eëd*[}n�����Y@��Me˯�m+m#<֣���j�\:uͽ�ErH� g����V츎W�f�d��؎�QD�����BJ��*+����D�0�楖��m����|�� WO�k1kI�ksM��ȣ�q���=�ӕG�H	�9?ҷl.��a,���@�P9����^�CK\��YC�[�>#<�J�ZH���R�8�Ev�{lw��+����k;T�͝ԍ<WOǒ�&�?B9�JwF����D���sS"��W�tB�34��?�c����O�QG=�i�С~a��������_�RNx �+D�Q�H]���y�+�\T$sޚbd(�F}<�fN1�Б?v��RE�8��OA�d�}=���t��9}�?E�%fqLɏ\� 1]/��;R�f������'�V?�RW*$�H<���Q��P
�=hD�><���{ԋ �7I��{W�t]�^[5e!_n�ǹ� j[�*��8�3Z�V����=�A�}+��4m7@��Ȅ��nÅ㷧��G�J���H�F��*�v~���9�;~?�t�:G���F�J��t�;g��k/\�Ghm��8!z
�������!زyG�rs���+�Ϊ���4�-M�V�+���	D/�dN9�F�	�;_�.��������M��6kk��L�� >��{��q��Ե���94m��|��0	= V��%��O�k��&�}���e��}y�A.�<�'d�q�cڻǄ��6w�s�+&KU"(�Q��5�3gjzV��"�`��Z�:�nF�#rG��X�\`sޣ�/�&&}��f����6�ta��%� ��ў	�롻ol��� �9�~c�����+{Fr�NO� [�^��#��y��Y ��%�Ja#�ѭ�&��p��>�g�kR&�J�����,v�Qƌ��b�����@xLlG$�j$�	jd�����Y`�C�	��[���xt��I�i�%,/�W|f�C7=T��A	F�{�`I��Lg�Ҝ#7��-h�'����r��\��=����_8�W?ҽGX���ս��[�FU?2����u��<[|;�.ah	�/�L����+�m}�Z���ci�L�ޕV����d�*��� }k��~������'q�7a}� s�����t��q�C�cɨs�)A�[��9(y�Rc-��޻�Eqː��oo�g�8BF:zVe�ʹ�InqX�W6�5#���Q��%�9f�c���G�N��9�$�_Z�(��Ů���J=p;~��Y�OR;�6r}+6������p�;�|}?�?�t���r��Q޹����׎c�;����w:K;��'��5���Իkw4\��8�"�=������?vh��~���~�H6�$�s��g�*��{R���I3��4;�.B�(x	�&�����v�g Wi�&�#Z�G����W �?���z9�k�$����ud�z���Z�]}J6��.A�8��cp�j� &�c�<Й��A*�  ��IEhȄ�`g�U%��ַ��-�sN�Q��e����^��i�e�Y[�$+���FX�d�"�����+q:��]ۛ� �� �U���FG^kzkCXh�y^%�I��d���u�ޡv�Уo~��5Y]K�u#�9�z6��.���� ��>c��J�z�(s�����vFA�����^���K��$�H���K��s�����$������8l�k+@�[�/���6��{���֩����(��ri�چ+� �;:�utRx���~���ou�R�+$c�
�/Qx= �����ך�����vbG;@�挞�#���ֻK-7�-;�-"8�Qv 1�y9=O�A�)ṵ���tp�������Ϙ�Ȅ"2�S���Lc;�H�!�Hё��K��<��~����c�40�����G��#��ǧҠ�:�Ɂ<�c���N8�^��ƺ�8�6��&��y7q����J%�N>��EXԠV�y�<`���x�"y$TP,O ~u�z+a���!p����X���񶿙��n�:Җ��xD�e�g����Yv�-}t���9�	��J�ք�7�G(v��n���ZԆ٧�w�s0� �S� �F���#��޺-=L&u%��ޕ��R�"E,@�����Q/��gb�����-��ѐ��}�YW��X�f��
�t�Q�֕�S~�T��	�@#�j�p��͂@5��H�K�Y��� W[�\��B�w	E5cX�m/8Un"gy8ݒ���_�5�3��\[�Q.̹�3�lq�x�����=���s�=� SPk7�wjm-�-�mA'����}FW����J��9��oK��v�2��C\��3^����S��?���E����*���$g���3�Ҽ����A#���� ұ�����HU߯�f���q*���I���9u8-��f8�we|�����c[IgLD����d�Ciy��e�Ɍ�7��\���X���VX�s"�F� �����Uui��\�1­L��[Q�*-Ϸeb�N�}i�ۅLy��/�'��2l*�00 �}+7��vL���uU�\<R��F����X�q��� k��w��sn�a�/�Y6��<��������!'''5J��lmɕ�=*�#��������jv��r�L���ޤ{���Ŏ29���7=�`���~�$������Z�服g��j���T�g�����8k��Q�H'��S��$���sW��q��9X"�����끟�V�8�[�B���2�����A�#�u�p ��/����;��_�i���c?� � �u��#�o�vAY�������[����zu���?�F�ŕX�ٵTw'����w����{I%��dld�1��z��z�w�U}�A+�OJ��\����sѴ@��o<�޺� xz�����*�X�?w��#��o�NI�ig��T�n�s��+��Wh-V�L�t���s�qЁ[a�}�g��ܶ�h�v*w��u���Ҳ�������[\�*aA 0��8'�g��Ex"�kxdTd;�\��u9�>��Y�뇑���� �����t53��l�6�m_ODY��*K���	�8��ƇQ������Bq;����˻��m>�$@�|�} #�� q�YւH�D�	R@]��gq�P˧�yR뺆��U] /q���#w=�S�U�����f��y:�+����I�(#Y�a�
7����N�	���k�OS�rOec>DP���l��bv���rzd�U���n�y\��UA��*���ڈ���ݎ�����O��v��̀�	���z��M�:ܠ�E�q4�<�{��F�Gom.@ن��RFؕ�,�	�� ꬍN�$��q�����a�RM��:�����ɖv O��of�ǌg���LpCgnp=}sM!��cہ�x��:p"���k���p��$�ճ�ne9����bWw�I>�W�X��Q��s�͸�@
�_\b�.�	�$��QSVe?x�4�ͺ�-Ӳ����y���\,:���ē� �5���}V���������Q%�}����;VөhM*\�C!�.#ȱ����6���ڥ�.n�geB�g ի�f2Y;�:t��֕��?$j7��A�X�����z#D� �У�O�]5�+�Q�~}�3������&�Hm��o|�����l
���"X^�F'�Gn�;� �*[�c� �P<*�d�$1�2��A� ��*Zev&�]�J��9�';����Yԭ���=��*�1:)� f�9�"�ش�X����~P}�Gj�n69���UY���)���Ǵ�
��#�P�e��g��*OCW�7����w'z���_JTC8wn��YZ�f��;��R��V�f�ԇX�m>�K�h��S\��;ZZI+e���>c�.?�u�tմ���X��O_��k�(ךΝa�+$�\��q�#?��tA^G�8r�Ǥ�Z����0�¡� �#-��VdĒ�\
��l���Xw����L�_�,R�
OQ�3��]�$V�{C&�KƮ��p8����"yu{���%�@=�rH����[N
r
6�z����r�9VG^���ƼĹ��g*h��qmoBČr˖�����9�F��I�1����e
q��͎�zsZMt���������e�N��=�9#���E|�,g�?)¶0~l���A�3�]�#��+��{Qak{娺Ef�/ �'�� ����s�����g��U��6+$��ۂ��#�^q��~+"9�؈�ca8,YUX� :��}��
��:�U�bIdm�n{�븟��Ί�K`�1�I��$t��ڢY=n%�R���KF�O�4�B{k�DO4�by`��)H�T����Fӑ�i.VB�#^ݒz����jǡ(�G���*��p��$��1����Y��U�?���Z�S��V�����u�-lɑ�hR�N�J`]юx�]�9e\��$���b�wq�=��Hq�T�ŵy�:Q` �2�{��B�G$��5jwP���ۙϐȧ�=(�]����/*����/�7�zFj	�R�����Ce�[f��`A ���]UO��|�P\�����ӭ�	�#�G֝�f�Ù-vH'�k?ˎ8@��cZ�6�N~Q�˚2��EL���� �;�W�1ϭj���1���'�d���l�z��H�,�=�jM���̍�U��V!!��7\�V�!�c<�׵�A���R"Dp3lUc��>����%Fy����39�5�f�o���A��Z�e���!r@���|7h�[�^ï� ^�����s��ܠ��Y�K��rJ�b�bi�؈w��V��Y-~p29�z�����'�j���Ԫ��R�I�E���ǩ��S�o��`FA�c)�k�����9�i�XOI���.FA=T�V������d!mb�~���	� �V��6�ŭ�|#6��Y`����Tn�Ar\p+�����m�$c�?��:��}3Ě����� �����>T�� ���յ�����䶄��Rq��;IѼ8�d+�y�j�3����}v��Z#/�����?)�'oƶ�"k[�A�H�%nFќ�ֱ4g��H� v�K��Қ=����{~��Җ�ڛ楡�j&���CP1
�A��� ��U�8N�#��UAR:�O���ŧ����Xc,ɐ	f$�x���V�Y��,(�ԓ�b�de��:�ҽ6�8�B�S��`1�<2���IrI�� t��W7�Z�m�E)�/Å1�$t=����E�4���$�y��ta�I��#��W�_^���U;cI�N���*0q{���j��M�7
l��>�3��� ��o�S���ꮵp�j/p*���X�s�n�e���ǂ~Q��Z��6�w:�SQ
�r���8�ҬE.��%�z�$��-�A�'�>�����rU�ݖ?ʣ���;�'���c֧�X�
ǵ�1���`t�h���E�#=�Z��d���rs�T&r���6�p��`�O^��m�<�OJ�(
�,ץ_�F��}j�.p8��k�ʮ��=;��a �jcW�`8� �� ^�ԭ��b�0� ����[v�mL������rHlu=�ߐew��?�UlKԎIUs�(��U&H� Vz�V䲁aeS���u�
B�( �����(����h�
z��!n�V��8�� �����O ��p�5����"~S�}2�x��e8�5r�P��{�H�Κ�!2���c�� �O0�� ��-�]~��/��~?�u��˪�WP�ı<�2�!��e@��;��T�ۼ�8'�UTUI|�%��G85�iosR��%{�D�}.g����j[m,�_2��ы��T��Sޑ����1���Q��ih��s���W�kH�q�Ǌj!1�$j�;-ӦyR��W��P,�ah�9�9� ����gt�n�c��zb���� ,��}�C�[F��Ĝq�{�u��#
������������1��U��Z�c�{���d�i�Kkz����?) \E�>c�a����>�k=G
��\v9���uk���nA��y9�-�5-��q��=��ѫ3�plᴛ�;M�w��)��p+��5|.l����?�p��?�x�t� H�L�K�P� ����nh6ڮ�u��n<�!M�Q�pr?�p<<�wЪM���1m�M�����(A�˞é�:E��6�.�+��22I��l�V�;hn��l��������V�.��=�[H%�a��vmc�t���t��E)^6b�Z��_ܘ�;a,�	d$�)�pI����9�SS���Rے��T������yd�RvV��BYyژ�  G�nmɈ]��W�@�ʬ�)�i�������Y@�<sT�y����ѡR�;w���E��,ay!I'�z��3���o �
>�=�nt�zXϒ0�2r�=kS� k��H�~�FH[,�N>c�*��l�+o�6o�����7�q՝:Ng�3��u�n��t���޳���o�a�WGp�`�V/c^�� eu�[F�#5,�` v5^��ᑗ����ښ_A�.#ǘ�{Uyn��: ?*n�/��@��[p�'�=sޛ%�Ϛ����QUUpp{{
��B#q��Ƭ �ƝI���h�E.8�f���F����R[*�G��b���P���PN=NZh�J�Ί��&�����n��-�̏tw˳�q��}�o��8 v��REi$O<3g��1<{����Er�sϨ���Mu1T*��E	h���|j�"�lQe�<�W׿5Q�m�H�/J��L����튝��ݚ�-6�HѶ���'ԒyK0c���o�S&8�6ާ�u���5� ���,�I��)Xi$o�jI& �B1�����	���R%ە'��b���f�xgOS�v�/�����"��G8���;�t	l�F�$>�O�?^�"@�#yE��C\�Z�f$Y$F6��jZkrᰊɑ�A�G�Vr�ˌ�$�'V �rWQܓ�2q��}�+d��q�	$b��ۤ����6�Y$��/tW���xG\�^~�B�L[ضH ��~~߁��1xa������r��C��q[�4��5ك��r�+5�� �o�t��VC� :Ÿ���BIp��`�㎠~����I�e# ��5��jg��y^Ѩ�2�����V#�T2ͨ�+�Mr�N�H��ι�5;��L� rpO?�jwpSw��: 1T䚱�����5"�d�Ƕk�o-/g�;zq��xnH�H=k��� ����=�ծ'H���6�	�=�愜$a^��uR��%ː@̬#lz���^+S�͗��#� ��`�ۭlE} �3O0S�r� ���qϥs� *�|�X�2Z�<�q�>ݏO�񮧩�F���2X���7��#9���Wړ�BĘϩ�+��<I��B@[�������a�\� ��3�r�V��T�џ��j�7+'c��]e���}�Z�I#�7L�Z�[�HU9pA��d��C�;�z :��TI�B�:=�vV ;��}�>�1�J{�#����֨_��bɀ��j-r�&.��1ګZ䬒7A֖9�ӽP+r�����f��4�(�/#d�1��MDw���g�Y���q�V�����z�=l�[��ǆ��kSN77�k���*�N�i��`���9�kY�G���+���V��EU-��ϭV7�@Yp�6{
�!'sm��o�@�cUf��c�d���/,�)e�"�x�}�N?(�RQ���ܩ<�f�X�	���G�m�
�1ȣ ��U®sv�)�&�H��=��1L�T{WQ�i	� &:�5f�ռ���]����x@P8���֋��w����G�"�y�jK�ܘ�2zdU��"��ӊ�̯�) 	?6+&�E�2Pz��]�4�.Wy'p9��b��By5V���0��1+}[����FD��/�Jγi���ٲMtP[��n'���5@Lc#�s��ĺaO�*��-��fL ����<��jA1*��ۗ��O¤�����m�2=Ee�[�_��w��W��Љ:���CE�#|��f9�J��@\�w[]��NW��]����zW���B����ea-]٭7�W7�B�㹪�R�\��d�s�>)U���S�Rc��P��� ��ɚs&�Q�`�� ���M���� '�j���P���3�sҤ
�o� tS*�;���)�q�<� ��z����횀�8�k�Q�"#^ ����]O��m�yE��9�XV�TsV�S����mXy�H%��,jޘ���:
�5�bh� ��)�Py#��#����F;{��{�4|&�� �'�}}:��M��-��,�@�Y>rW��8��tS����=*��g�J3Ea2~le�_�T�cK�<���>]�������<m�.���jo$����y�C�'<���=V��)��g�̑,*�������A��Z5����$<�c�F5��j��9��ˏά�j7�d�ڬk�s��N�.�N3{�������H��_�׺֠�7R}��x�1��A�J��3_�,��i�!���c��d�A4D��\0�����Ɨs�ۤhH��r��o4�nmbwfu9+�g���9��m���;����یw�9��ųȶ�F�������>��4�� ؖ͌l������[z_�m4��h-�(8�9<ճ`1A�B��^���U)��"�
��U�88'��"�ɕ>dvG���xN��!U�U�O��Ȩ5-.��1�����=s�kE��/>&�����z�ױ� &�I4�ɑu g�\p*�8�w,��B����n��gi"m���K+;TG���\eX1]��H�0�pm�"L��������i(اI��;̱��ۿy�8�թ?�0����4i����(�ī��O׏�2�L��u�zȩ��m���֪�r��%�!��0)ؼ(�zՖ�XBI��� �鴝"+x��� ��Q��KiUI�(�i5��z��qw#�Sh�7H�' r?�j��4M4��q�X���y��Kqo��pr\ǽ(�����e��AR:��^]����@q���/jYy�����rT�|5��gw&�-��?�{��[F��cF[G���O�WF�T�w�3ɫ�1,�;l������SX�i�Ȁ��@���~��)r	җA��4�YO�95~�O��%S�?2��{~ZŦDU�5�?�s�z�i/]��m��2z�� �f�.�Q}�y ��aIw*�R�}�֤�H4�w�2# *1�� &�uKs�Cq4�Tۀ-��}�ڹ=_�c�ȅ gߔ`ű����T������m�y�@�s��+���߬�#[�|�q�Mv�Kdǟ�H���֔I�_H �܎�7� ��.�Է3��v��?\Z_%ې�A�e�|y$�q���Z���A���V��x��d�����pjq���� �ơ�*��v��Tl`�:x��ڨW-���8�� ��i����2��Ê�"a�X烟��:G�e�dS�����S�Չ��=v�Cw�4p��4l�a�"��om�oa���lr!2d����Ğ� �~º�!K����(�ҼG}�U���s�;����XQvn'/"s�:o��Dx�����9�k6�î8�K���.03�|���j�j�n��M�:���Q�)�r�c��pO����{�RH�V%E�\���I^q�� �V���k6H��'?��V�^�w!�)����>�Z~�p-M�N�2���Rc{t�v�2�� �#�?�T��?�R@s�Q� ֦`Z���Oݔ~��^h�}�0��� �i=�Qԡ��),�Un!RXt��T����lF����t�R^@��Y̑�+�7OQ��g��%d���xy��F�BR����1�r����+iv�/����G\0��� �tZ]�#8��� �ب�Ac�']�0�_�(sGO:�k��
�����t�J�`"��w��׵_�e��r2�g������Yj���V��	���O���o�];Q�x	�{��ksY�[�D��e��O��\�fO�4���y�<g�鲬���8�����(��ݬ��I��^T,�r�� ��pߍt^[Y4X��F�Wt�(?~+Ma������� *��']2y��i ��|�,��#4��Ƽ9���V�\l@�\�%��\l��e^��cP�<p�`�o����a��z�)wc5�s#2^ X0l� ��t"��V2�FM�Z5+����o�ǟ1#<��#�j���1id���rǽZЯaىA*��?�Jf�����<�3 d�=��8��qI;t��ӯQ�P��l�����V��d�(����sͨ-ͽԈ@>h`����^������V�8���Lٳ�K�x�$l�m��8��A������DnY<z�?<�i����������?Ҩ^�3#��ߓ�?�jn�ұ�ͫ&�
O�D�>�)��Q���-�ѰQ��?�5�=��9,�)<rzS��B�9��3I�M����h5wK	U-�.yv�= �?�Yڔ��\�ok+̣�;6@����@��/_z�Ӭ���rs޲�l�v���&�[���6�p3�뀸�k�4������z����~�?0� g�`���kϊ��2�܎��MYQ��|r
~a��~���� �g���I?��9�td��(3����R��3$d�A�������K��K��?�� �O*�c遅�3���u�Z�.[#��Vf5��I c�#�� ���b0@>���.W�'$�
c˽q��v4	������_��*o,����$�P�&;�A��>��t�0R�r1�����V����U�V72q�ө�Y^3�2���Xj���OÌ|ޕ��'�t��/V��۽]����x�C���8$� Zɹ�l�d Js����e4J�mͽ'�p���	�u�A��r���3j��&�]ˍ��1��zWw���	�]�<9R	�zV������>�L�=�]Ѥd������/��� �S�q��]k�\_5kk�C:Pc��3�ב�0���n����[��>\����c� ꡴]��k�5���3��;G���+MM$c;�<���5�RU��(0�2�)O���֥1�R0U88�hL{����
ZL��U��5)�g���y� z��k�"["ͅ��g��Ҝ5�x�"B�S�9霚.-;���j!�\� g���W���,��q�=���4�vkhv���!�� c��3�#yLۻ��z�ji,r�����8{{W[�kC�F	!�3�Mx���%]�B�m��U���"���&c��8=�j\���s�,5�7�)�!�Zދ_�2\F�e�+흫�k�'�#�1o$Lf|�1?�T��,|�&w�\� ��'�S�4���vЍWS�X[q���01�}?��Dk���C��2��8�B�?���yl~-�m!,�T��ȹ����I�&O3�e�U� �FX�I4]0mu;��"��nmlqy��[��Ω������s���r��F+�/5�ۻ�����8QT�yf�y�����ՏC���i��m��6���\��d��;�s�8��w�Tw*�ht�#�� <Ե݋�Ob�^��Ã��ǵ?�+e�f���e��������.T]٧lT9@ba�ֈïL���:ȇ$������]�;c�4�)3B�<�N9c�WM���ݎ �j)G�_?tqZ�3�jW=NO�A��kr�<�q���Z�m�����=k��m�v#�+��m.luW�ϖ��?�{J����1�h<{��ӽR3H�
	�6?�X�%Y��rC�|y��FH�/��_ִ:�� ���o��o�E��}�� s������  ?�QEl��� ��� ���խO�>l� ��E�?��T�zO� ]EzV��� �E2ݙKc/R��\6�� G�Q� gM��?�����?��QZ�:Bh���� ��MQ���S�Rjl���ִ���B�*$C5���G����Vl�ne^� ���S��(�o�sw�E� ����U�ٙ���r_��_����n�� �}G�QWOr*lʍ�J����(��0[�O���� �]^��?����tGrI��q?ʚ?����(���w.��աSE,��� S�� �k�� ��(�ٔ��O����O����� *(��t�$c�� ��?ƙu��?�QZ���� �@  4   �� D O G S - 2 . J P G         0           ���� JFIF  ` `  �� fExif  II*         >       F   (       1    N       `      `      Paint.NET v3.10 �� C 		
 $.' ",#(7),01444'9=82<.342�� C			2!!22222222222222222222222222222222222222222222222222��  �," ��           	
�� �   } !1AQa"q2���#B��R��$3br�	
%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������        	
�� �  w !1AQaq"2�B����	#3R�br�
$4�%�&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������   ? ����FJ�����u;����V�7�AoP����)�I#�Ct���ט�<�S{Yc�(�1�֖�=��lY���	c�����h<�����5f-'P��4���pH��>S/��EU9r��ڄ[����R�a�#�5��0f�,"���#��@��JFi_ 1��Q���:Ѿ��O�խݺ�T��y�߂��o�����IWb�B�g�q�k˩�| ��eμ����`뾆�����]/���j%�{�=X(�����v�	�����y��k��|Gg}�����\z��ߊ�,�{}E�=��Dm�����V~�]�ti�cz����v����� *�$W@�Q��� ��!��9\�܁��������`XV�E�c'%� ~Ͻ59�&��v��dH�e�|d������x��Xѯn-µ����^����z�/s�J�/-��@�A�Cu@榕�={+�Q�t�$��G��-N���S<�r9����u�]�����7��/��@r�������v'�A���s����m\�h"bz�����궾��m�+��˜?#��?��fE�S ����� B�������8������U��-��m/  �����h^)�֮�$��cE��On:�V���M�۝�� Y��H��ӟΟ3}
�OR�ך��Wt$���?�oΤ����	+����l~��q-��c
��y4������$�����]��1ݘ!,���;�� ��4^��/.E�������5�h�F��Jk��P��kNkfa]��#N��H�b·m���'�=������Ũ���WL���-eG�3���UK=/0~^8���#����ё��{
,5{�z<�\J�D�q�+>x�`@^'���Ae<����1�D����p�Ե)#���HW���*�j�ɐg�פ\�w��R��8�^e�_][߻�?2�����	�Ȟ!�^�� �D��h�li:�V�)n%�Ĉٺ6=?1^omrnD2���=�j�O5��@�oj�X#��N>�~�E'k�,W����W�'����'���T��Y�x�N�2����y�+��l�uo�.��{��`~u�3Gˍ͸�!9���IR���X�K�#ӓƖsE<щ�(q�8��rp3ǭs�,��I�y]����X�~��.[Þ��Wh��k���¿�� �O�r�q�.-�Yco�2ɷ��){��Dq*.��ɓo�oJ�����\���S�s�}��[�w�!��$Q#�n9oz�R��I�	@�J�7PxRzs�g�8�zך�6�,�xn g=؏�;V���x_����e�����IJ�$���k�ƣ�usaB�a�3��Q�I�߻�����[�T��G�5����f�D�w\�� ��gi��ӭC���(���!�7$��V��f& ?�uռp��LN�����8���'�r0F9�\G���� ]Y»P�X��2�靵��{��*L��^�~�~�����ӷ��R��O��!���V�R���^Ks'^�[GkiV�*���s����;�}j���w���̖���H9���\��p�������=�LU�-��L.cx�:���y�*��ux�.,���	�D�zJ�5y�ý2�w�/&39����v��K�hu�
�p\[�GM��߈�=�C�}H�{i`C���X��3��o�E���PRbx{W�A� �.Z v����縭/�1Xj)wnU�o�{��=����\�O�9
�?)�+�ѧ�U�fҥGq3Z��>[������;�M�G����K^�,�cyk�s���O�qR��Hf�X�V������Mw���u��i�f�θv A���4�ö�z�)c������}���E/_�F;�蹊��������V���6����7��@�F{�U��a`L�Ƒ9m�(�5��;�����ZKc�SOsn�[=:&p�J��R�ձl��si}$�I�,���jﲌA#�}jo��TRvF�k��uV=@#Ҟ��9�r�85�[����_Z�;Ŏr�ى���MM�4:��|�xbp��h ��Z��o>I��ݢS���\�'�f\p�=Ooʚ��7���6f
ܟ���z�u6��"��X~��X\}��̛��'#������ �1���\~U�`g)	��f��Ȫ� �fF���՛��"�C��#E�I��"L������9C�"�y%�� ɬ�;�VV\��Ӛ��W�;Z��m��֦]�ի�(/m���8#��� `�ن@��&�Q��<�Z��I���o�(>Q~���k���C�C���{{ױ��M��ZݩR�2:�Tמ��oQ���Y9ʴhN�o�.K�x��-�$7rj>����+K�xN��s���US�v����R�V���L��(>�� �zկ�Oքw�J�ޫ[��iq��x�ٴ�4�&��bv2�8\��G'��
�8Kd8r� �1n/�^��{��	�(���3�1X3i3y��yd�=��5�-����ZOn�F#9R~��"xsS`^=:啎��q������_j�i9}�9�����Px���Id��6`��}�����U�n�.��+!�r?�Jǳ�ŬN��>���L�SkVz���7v�����ޝ#;��R͖�e'�~��i�(�;����G�����)#v��<���LO
����J�5�4v���L��nc=�8��ȭ �9���yRV�`�s����ƴQ�s!�zV�$e����c
u��?�v<}?�ט�s
ʮ�!b�ns�W|Sz���,�i�VR�,��� �n���Uf��MI�Ǻ�8��e,��=FGj�nu�[k��-��2X	��� v��j�ҼIt�m൶C,���O�錌�~��F��d�.
I4F[�぀j��ߖk";=&!0�M<p���b#�G�y��]��l��>b��@�c�7)����\d�M&���(��ci<������zsJF.����o�K��4�!��``�]� �m����e��'[v�>��
�6������\��İy��R�(�2��R
��>����9��|Va���B!�Ii0�v�֯���pM+=�*}:;��8-�AM�r�����s��*с���KE]�.��ֲn����K�8hB�� ����B^G8hxb�z����I�DtP���Ρf�B�# 1�*�j��$}���^Ha���H��9�=ZdZ�������7��s��w"E�I昤�[����2�B��9���fiG"�z�8?�i�r�I�������^mM�
G��M��ʍ�r:�D�8�����>Ԑ]�BHJ�q�w�e"��j������sK���8�VcEW%  ��N��+d�ԭ����e��M�>]��)..�U0��S8f=MT��!guV�I=�� O֢��T��<`�]�:�	!7,��N�\��� ?�u7:�[H�O��\.�z!Xܷ$�v�$�����X�#����)�[B9u��uu��s��hI̭Ԝ��5o)�=	�n���l�%tKћ�q��H�\��&=�J�8�0�j̲f���4�[4����Ą�`i� ��R�Z����S�-�w��S�0t��j��lAǙ(^���O���:̍���T:���PI^�Ys�I_�R���*/t���N�	si���va����d�����e�u<+��E_�p ~nGN���l�n0�RR	jm?;*㯱�+Z�X-$�8m�A@�`ǹ��X��;2=^��8�y������4��27/ן��Y�5�3�/s�)���r:�y�MKs?�5h�y���f#�R=s�G��{TH�&k����<�IUr0x� 5�ޗ9��I&�!���ǮEs����k1��T�d�_N���]t�������I'�?ZǺ�֚#>����Cs���ǝ������~�W]N��6f9��-�B!���>���Z�L�=CJ�݇�BE[�4�]"7���y}TD�S�G���4���%W�YC��
���H�t�?�n��Q�ެ�9�H��`I ��ڭ��)1$-��+�g�#����Smi2��y�r�lg��ϰ���n���[���2�!	������VUέuar��)�D	:;o �Sߥk�ٌ��;�Ne�=F�T�T++H���j�y?�j���1m4� )�8�x��apA����[O`-�XF���.z{V&��^�q"�Z�����C7���'����-��}����v{{IYVB$rya�������,��<0bO0���=��ڦ��H�wu�L@���FOy�mN���]�ڣ�H	e��< ~ls�׌sQ~���l�ZY5k%���M	���|�è�7z��i֐-��-d�V@�*�}�9�VN�-���l�����Ӧ{�?�E-�<~�x�q\��8~}���4���n��5��͛����y=��IuY.����?)	�I��8ʔ�ȧ��\����QQVF���w�R���~���!%� ����,���C*�#'��e�Hc6I<�S��-J��mj~{q�z�]B+�܁�����j���+3,�ס$UVڱ�&����սIB�)�u�'�O?Oz���;ҡ6�0����V�&�R���]�1�
C��k2�B�M#nlJ��s�R������OҠ�wh����|RkQ\���ƒvr�q�s�劥{t��G85}�Q�$(����=�� "�ɉ�YrP�
�/�a$�<���O��d�M�1��G��[ yW 3�sRjD�#�_���lP��ٻ�F&�]��rA��I�õZp݆k��i���]�� ��>�ֵ#;�*�s����g�VrE<-ɸ���J�䵅����>��^��.�܂eT �����ō�v3�ʦq^�q�h�l��j��x� L�RkO=$�|���?@;�r�A�����:W�h>���pQe�͹� �s���q���{��."�m�))�_l��*[�����K�u�sWg:m��� }���q�κ;�,�y0ă���
�Yr��-e 󦹕<�b�Pf*6����N�Z����P�2&N�6���#N�V|�ۃs* R;}{ӵ+y/���X��>avܹ�;��}��1��,�15����<��@�O<�8�����N���[{��7%��Ą7$gipGJ���s�մ�G=�k��3� T�<F�|"���ISwr�9=I��$�4ٖ��{{�E~�#�W8''���}kA�4��,񻈤s��qӯ_�\ɾ�U�[���6��� � :�:�Ϧ�&t�m�Ϲ�g7Ӑs�VJ<�@�KC^[8⺷��u2�G�b��\�.�����FI0��P;s��y��\}�D���a���+�=
��C���~���n ���Z�M�غ���K��o}��_1R�<�����4�WY-�w�`�3d6� 1�I=8�a|���)��H��J�]���'�VG�,�0C@a�9 �t㚹+1������ƕuu�H�p)	,�p���V"�=��,r4n:2�Vr�R�
�U��=?�_��[S�����\��'�P=����Jǥhںkz0�Ak�TP1��zs��N��k��M<w
w��2y����9g)��Fe�w�GNNk���i�-#�$����\u'���J�sB{�s!ݷ=�2K�%�7�8����f$�paPMs��5$�\�q!�9�\�)c�8����6����(_.�_'~�5[���C	����dV��W`�zU�F1$k,R��V�d0p���c�u�������ǵ6.�;$r,�˸u4�<H򖜖x���4/�篭:�.�xs�Wrf��d��<��#,��zR'��*~�P)�j�gq�"edm� ��jS3yG�Q��?Z��iu�y<gB`_Q������qRƊ&-�4����S�T#��ed������R��C�ޱ.`36r9��Ί�$��یV>�)���1��>������A��n˧�sְ<S.�h�]H�j�:M&s"�=q���Z^�[�=��-3Rc9���-�H��kJl��χ�0"���&8q�<׭[���!a�1���bU��J�K�"��*���袱��O18��Y+l��&��k[�P@��V��{�0ǌ㊛��,�qC����dՋO��ѝR��[���$�\�A$�G��l�s��&��X}z�ꮟ��G*B"�O^�lƍ��J%-����<�r:q��Vw	�%fa�o4p�*�d�&ȼ�� ש���'��(kp�~Q��Q��6:���|� fA�s ��ߕ@� [w��0�J���ө)$�.�H'��.Zr��d�-צ�:��$z�=�缞k�m�V��oY��F1��t��t����K~�<��<�����7��1� ��?�N�i顓Vf"������d_0�>m�X�:��O^�q��ǁV��x�htv��� ��5�q��L��ϔ��)b�����۔`�t=?J��_&(��k"�Ic��ʞ;�3�h��#��t�E�i�F��|�lp�m�z�s�U�o�]$B�(��nq�� 9�i�����"uuh�O���_�g�"X��Ɍ ��������E�y��JM5�6$�;��������w�X����J��"h�8(��#��Zf��&i$���@lo����U����Cv�R�VgtF�{r �=M\���`��I����3��\j�ćs��NUs���Yzu���!���?�����z�޷���%�����3o��*��w$c��jd0��	,q�O>��k';#ք[d��\]�i�<��3(�	�Uy�ه�>�d�	\tݵED�L,�q�W3]N��hW�pzpO�?�� ���:8�R}>_�R���B���u6*�o$Ivp�zQ6���Aۂ��ҬI���w��;w����4���qޓE&Mqj���<x�|0�p��[I@0�Ny�{U9&c����5,c��$�$���5^h�&+���qV��1��`�u���"(+��)GA=K�
s��MJ˟��q��c>��o�ZP �oPG�w2j�`ʻ�'�Q,P3�����qUq����CeK��'z�]�0��4��,�1k�QW��9��{vQ���F$7b�B����\��!rCo�޳����\K�7n=��[�.9�GJ�a+�=����^��ۯ��Ǹ�����fe�����P�x����E�)��2pj�������ԲL�!%��W��{��Q��z��9һ;�� �²;����Z���x �?�� ��L�����@�NA���U�[�䬊��v��Z��؆�C����5LAs%��8w���`�,z�#��Y���L���g�Ǩ����9T�Gr		�z��ڢ:	�o��~�:�����Y����EsZ}�Q�L�N��e�V�wu��]�xa�'x[ΖUD�Ys�����3��9��n��9�v�!��#j7!�-�^I/K�2�$*euQ�a��>�5b��QFT�O�NR�IA� �.{�߿z����:�
���0��;W��ƹ�n��hi#�-���s޴P�rT�(�X�-!��6��<�TX���:q�1���W28��"N����<��d�H��jk,��}n�.�Y�>2I��k.����Xf�21*���>��R�H�u'�4F���ެ��(8c�����)w�qZzV�ep�ee�Rr�9	��r*u�,-#���PC��C߭`N��j0���d�~f��	��89�qS(�zu9��6�ui��=�QM#�K��"�c�ߊ�hD�t���|�8$���� �+��f�]Y�&Xc@̸�1�:TϨ��� n�Uë2�u�� ש��Z�{.�kQ,���ʆ=�\��Ԛt<H��2j��./��F\/�=����mK�LVz��Z�]С�,z������@�����CFѨ9Shw2-��������NT�G��5f.�) �l�P�ڱ�ݑ:T�Rz�K7�l��U0�?w������Z��*�F7q�{�Ѡq
O8�Y��X<���֝wBέ�g�Ҭ��#ds鎂��d�T�x��zVLІ5L��s}��K.�� ;�<e���P�ù�3�~�X��Pܤ�cx�v�� �0h�>�^�nN:���Y��ў��X�@����Z�:f��sP8����.���TO�5�Ԛ�J� �Qޣ I{��O4{\0�.WW(��T6Q�5�bjdvE ,7w�]q,�8�:���g��\���S��`�h��U9�o�p4����m)
� ez�-4���>��m;������N���u	E��,����W'�{W�j��q��2���c�>��O�G}|������'���޻c4���*�]��p������=-���!j�[���_=�݆U u��q�W������$[�F���qҺ�C\c�����S�΢Mt4rosOΊ�#`l#����~��Ƿ֫E2��J��i��5�Exe�K���D��� v��
j�:�3������(��/?J�C�Fީvͬ*G,1�w���zt��z��eY`��.���Y#�`~a� ��oy�����m�]d�s�� ���wZ]��F$�G�9�:֑�J�2�r)_�;.�.��K4q1�㌞1�=럽�R�'fu�TE��a��� �_j�Ic+��n�d9M���=� Ʃ��M��U$d�l��k�M�w>�[uH�1��s����rגA��IՒ!����� �#�y4$��� �g�A�;;`c�n��}iy=��2O�q�����};��.��T���L�vɾ���Y��0�Q���LVN�kou����Y��8a�^�gޤ3oi�19�i����YQնM�A���jё�-<j66�4W)&�͐�H��OJ�m8����
�����+7T�Gۧ�m��<�6������>���+�M�Pp=��妣�Bҹ��H�S�G�vEsH��C�Ҫ@�,}r�^��+KH�`�q��5�۰�7���ɂ�q�>���2�O �9��ˉvA�\c�Sgi��� {�K��F�i����#�֢}x!YX٨�K���7l� |���o�4K8�W�x�?*/p���tɠVP�i9ZϺ�fRʿ�{WoPtc���^��P.#R�Q��"(d��#���)���N{v���ɧ��	^�Ve�220*�ۿJ�@��8���ppw�
|-"�S�����͏�e���� S�yw[��ұmܵ�Y��H����:8��O��j���b�a�ҭB�����U~��D�c��|«��t�9�2vdx��>��*������%�yw[���p'ޝ>�H� ����z�\�+YǗ���ҽ��`��I8ɭ����`�Ȭ�-$��zǷ�h[�< 1����'���crp6�T���"Ba_�O�f���̛yA����/�!S��{�A�U܇+�.����w�6�ڼ��Q�}ҵ�F��d/^+��/���کuV�W?�� =��m���4y(��I�P[[���3<Us�b�y�N�1��2��3�aW�Tu��W�t�l&y-���I#� A�}9�Z���7�lE� �Ux��檚R���U�6��H���9�ϙ��֮i:�&�gt�g+S�p{�7�y�.X��!O�˦]�YO���t��N[���Σ\Լ��h�.��X�3��~�VO>�d<�>v�);rkMӮ�e��YNv��8ϡ4����&uynXd�${R��]��*j�����|(<F�tRC�KJ��*)�'Pe*$b���s�J��l�$y`{`����iKs�䴄��D� g���P�F� �X�b�����u�Y#�2��8�ǯ��o�5�{��0�&ȁ��3����=:
a�(�g��#�]���(�֧�R3�Q��RX`����'�>��� [���!����p�����#5���g�DA�ɻ��� Q�����`Mǚ7��03���sJ0��8+��4��`pGN+pl�م_Aֹ��.���q���9�\�7q֢�=Zz>�%h�>p �#��K��(c���is�s�7�O�a&l�Ϊ�R��c�ح졹�<�7`;W)a0�U��9�{ּ���u����߸5��3<#c��@��֥�Њ`�i��T0ǭa�/�;$H8����tnB��=i�V&��1J� 7�Z��*k����Hl37<TѤ���O�S{d�W�2�@����_zz��XV�)�:ɕ�N�s!X���B�r���+[����)�I����]OJ���٤��۟��֍��孼E�,8��u5<r��U'nMe�gq+J� �ѽ�9���H�,�$gҡ��eۖ	BFP���pz�>�=���\�_Ƥ���t ���*%sH���~YQd�Kz֖��mѾ��Ϸ]��~`M_���<�����N���Oti)��V�e�[�A��-n���OB:V�J�;O��fi.o���g���*;�p{�)���nI��Y	� �������p�R^7�)��ι��\�� ��_=s��>��6����<>��3�lch�8�$����+d�"겣۪� ���w��5�a��j��8����=8�5-~-CO����P������I6�ֆ�ޣ{bf,X`��9�Ҳ�ᰘ���T|0`w��Y3߽��)Q?�=ׁ��R�����tܠ�v}�_׽\���{3�X��v<JS�0�Z�,�����eӟ����T�z�Kd�M0�vb6�V-���T"W,c9�g����Z&�g	}�`<1�,&H�BQ�#��?OΫ\M<Z�����6Ñ���8���<����>Tyc���AϥP�����C&ԈpP0�$�/d[��g�g�2� >ӅQ�*���������ա�\M�[<� �su��TW����W���)�iMif{�Eo;����x�s��8��Ҫ\\Cl��=��x�*�GU�:���]@��ֱ��^Yf�Hn,��<n^��h�8��J̒��! G���,�Go� Uq���uj�D�m�?{�����c߽t�մv�YU�T�W=F ��BPl,��}:c����6���(�������h���x�����˪�@%@�ڷ �OC���4����Z0���v�;x�v�%� ��Mmd�[bQ�W.�GN�m�upFB�x���6G@�Y%B�٫N+xUT�v��ϸX
Jŗw�ӽiE$�"��cю9�(ٳ�e�T`/'�O�����ݒ����4�i�� }q�5Bg�Y�� n����1�zR����Uo��ps���}3ZQ\:�$c�g5�k���T���j�fD!ܠ�-Ȭ�4�7�&M��ލ֪E�+�T�ݏ�MR�8ʜ��q�Ƣ������=��l�G5Vx����R�.����RH2Zw!��ń��Q�un���eDb����Z�n�2uܽ��s7����f�Y�"+9`@$`c�ҭ[9#�N?Z�DpAR;�m��e�~oz�Dt�CtC����2���A�S���b�Pq޺+#�q�uGAKS����/d�����z�ex<��������ա�U�ģc��_��?�sz}��>v��k��]���^�^x~�_3	�ܯ?Ҽ�o�Lr?���^?׫�F�R���~�Хk�F/�J� 2a?�>އ��ғ�ED�tC��5J���Pz�=j2�5��12�F�V k�����A�o%��|�˷���ڶ�"�Ѻ(�R�l�  >U��c�U��;�8^x<�`{��R-7U���lC�ȧǥj��h
3�qF�&"E�.��fNBz�_�֯y:R奙e�����DTm�K�m���D�N~�4�4x�.&gW���9��o�%��#�Y�������W�S��pZ�h�G^Wh$�^��k���$�ιÈ����K[�h�_0.�;�������s�5ԩ��m�a��rO9�T�^A�yLS�s�]T�w�ʥP���A�b���y�9m��M;XQ�������RC�s�\�S݇�c�z��-5���D�
�}j��$�C���1��\gg�5�C���oV��t�%��Ev;�Y��;���O� Ur��ż+��Xz�
ֹ�m�F�#7�++3�jBl�'�L���BZz�4�I;�H�^��]u��EN2rXsW��#�����I�V���Rt4Jl�įm�4X́��t�����-3��;� �k^+��`�w�z�)���:t�e�W!��R!W�z��@^3���Ȉ�?*c�F8N}i���Ջ��f�Z�x���*E�V�q�1R�����i\vh�P���Υ�c�Z�V&�G�*aM��R��yP/����HUc���8 0�֓�@�h�9�P��v�u�P3��Ҥ���~RX����{U�"���+`�(T�$��f�_�`�'�h'���;Na�Y��q�o���`�L�e���r>��'fsN �V��MX�A�x�Y���Z�)������I�6S�׽te�]��1�r1�]�=:�o�� �'<Ttz��:֙s�\��1�g!��^kw�]OJˬ�ܢw*�o��zM��Ƅ���ڹ�Z�Z��~�k(�\�0?,ֱ1�[�hWBq˂ ��	�㸷{y�I#q�V+�M=<֞�W�I�r��B{���5gOԵ6hu$�m�s�#�i�����?ص��o)�;hm�9���x2��w�1$�� �񭿶�͇pA�OJϓ_Qp�i��^�7}i�&'dW��K82�m�`�X�3�36U@=
��7Qե��������~��䭳4�Zfe1���f��/���왲��{E �elW�Agc"�L�	��O��^KC�]d�����v�v��4��y'j6x�έF���f�[E��q18�VE�\�;mE��ݝ��8� #��x�6�q�ٱ��4R+3�6?����� q�h�	5mJ���;�?2�����:z~5M���m�4�#��ig�j/�SJ�DO����nF�(�� �ܿ0>��Sm*Q��z̋��i�b��J�UoL�rx����|�S�!v��������ckP��*<�����k��ƫ|"��ɾY$B�;�=�=U��G�^^�W20J������ZZ-��6�0ȏhRNI��N�pGer�����)'�������aNy�槗K�̳m���LG@��K��Yx�<��M���i<*m-���a֭E��Ѝ�a�인����\j��:���BF�hi��*�,���\ƭ���!;T��zcүX܈�C!8*ǑY{6m���ܸm��
��H�i\��/°�c��9�(p�Y=���u���ZERzc���>�q�t��z�"&����Q���xTg���B�pL;X{�U�L��/�Vpq�����H�	�j}�^Љn���;�=AS�Vp�s��6� 9�)r�sH|p��ʐ����*w�$e�qQ�S���)Y����!#
d�0O�jזO�A�aJ`$g��9��^�K.�gץee�r|��a�]�����5���K"��O����� �@lp�Wl�`��j	��H�����B�JX�KI�G岷%U�~4�Ir:�H�2�w6��5�4��J>�zk���W��c�?,a�{~��[ַ.�W{b��'Ih�:ॅĊY��H�N�C{�#?Ztr�>�$�Ib��T��k����=V-B�/�+�y��pSYj�j�nl'xYH`��2}�`zֱ��9%M鰥���	f�l��ܻs�	>��5r�J��Xq�`�A��*D�%�id��BU��G���7���U�cn��F�#-��zd�Yl�9o#+]6�O�u�W� u������&��x���o�!_�cں{��T'��1��r����Y��� B��w�qV����\�9��{u��[r�`~a����gu5��H��H��7?�j��	C�J�l�dJ�sjtĒA=�jM����D$�M���! ��OO©���b�P/bT����u^"-�Yc�2#9���J�y#�Ձ�R5����Q`�]U��O$�2�'DLU�a�%X.�H�����렁�[tU�� F����$�(�}�LF �>dD�'�<����S+-�{-�"ۍ�펦�x,���P)X�+��޵VO!@73 6�����P�I<���i��&�j'?�y��-y����A�T'���hª��
��~�;���9��mY� y��+�o_� Uliv�u��J5ĝNr�c�� �v���7w��y�F�9,���`��PZ[ǹ'h$����y�ˊ|�Z�#�m�)�r���TV�B�5��#?ɓ�*�U]N���K�|)�p[���t��:ϛ�*<������@~���U�(�'&L=9��oʈSg������HPz`�t����Q���|?ugΗ�\�@���Uitۈ"ܧj��H�m�%��u�s��2������j���>�f�}��x#��==:Ҿ�"Q��([j3[͋����g5�#�wlP8*y�����߳��:ɞOᚙt����:��
p/�Z�#��顥�m�i�!���|:�1YF�a��TR6�i՝FZ&BH����S�Ib�w�)��e����C���y,uS���:X�����F���u ��ʟ�\���4�I9�gve�0;���Q�>n���V���(��6���p�=O|~<�Ʒ:8�V{w�O/�W��+y�+�X����0�� Z�2�Cv���n���lR�%3?2��G��9� H����j���t]��<Qk���u�z���]�Xq�a�~u�wtD��P2�ʲ�� s��\���K�aD`cQ�͑���7̮C�\$X�e@P�*9�ީ;	���Y	8�F9�/�ۗ��{7R��9⦶���A5�`��(���3�ӲD݋�H_&c�F�s�3�_�Ҡ�����%�ee]�yo� Ugx�K�[��ʻU�����Ig{wq���Y���r7*�����V��rN���������ե��+�=2j���D��5��s��4��c�pe�U��F	�3��>���M8\K�)BAnzm=s�$���4tR���o�, iT"��q�N���ֳ��ܻ�dL���gc�����+[Y�7�����Ο*��#���rA*����h����8�~J6F1�sZ++p�-ߖT/(�����hG:B�d2������$�V��5�YH%�;U�������F���I��V��I��f������BdU'$u�}�Z��,Pt%�Nq�}:�uH�&o57 �/%�����M[dK�fD#n�����n��f�g��2�X����i�ٯ�J��.dS�}}*�I4,C����ۧ�=je�a�w�ׂ��=��t6��ri�m5�# l�w���ç�>�����21��`��.���4�)᝺Ē:����͢��8f�H�Ù
��j�W8���o��֢�?�'���3QEn�<�]N���??��t��|�� ���(��ۇ�H����?��g��� �� �QE5�oq�?��� ��_�U{�B�� \���EOR�f��>-� ��u���+I� \d� ٨����Y�E���_z?���Q[�~OO� �[�?�d[� �~O���QEL�G	�/���?V�ui~�� �w_�QY��.� ��� m_�WS�t��� ��(��4�΅��⸳� -?롢��nu2�� ]o���Ǉ���_�(��_	�~!��.����է���� q�����j�8�����[� f��� Q7�s�E�~ͫ�Vj�;�Z�U � �����\5���F�D:g��o�%��s�e��|� Z(�[�a�_y���������Ҋ*Y�s?����ſ�����AWV� �(��[�.����� J�c�G����Eg!���� ��V��>�������?��   �C  4   �� D O G S - 3 . J P G         0           ���� JFIF  ` `  �� fExif  II*         >       F   (       1    N       `      `      Paint.NET v3.10 �� C 		
 $.' ",#(7),01444'9=82<.342�� C			2!!22222222222222222222222222222222222222222222222222��  �," ��           	
�� �   } !1AQa"q2���#B��R��$3br�	
%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������        	
�� �  w !1AQaq"2�B����	#3R�br�
$4�%�&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������   ? ��pڬ�,�Cʑ�G�~Ê����LE�b����,r\^5�H�"� �9����i��n獳���1䁓�z���YMGr9-���<K�لGh�FO���Ƒ}�Ke'��Bf����UwoC����T�]�|�m$p�
�鎼��4��t%[]:]�~u_��~�UI_r�ލmyk�E������!�v�J̑#����(�c�f��IKd�7���`��L�r���-����A�׎I㷧Z�l�X ��mVh�F� �z�轺�SS��t3d�{�&k��/�$�� ,���:`󃎿Z�4�RF�ɲ@�>bGR��<��?�*ĚͪjKo�\ȒD�P�r/������E�����o�kH�ɚ4!�$pc֓�.4b��j�U7�V2�HP��!OL�����8����-�ɾE��y�0�$��?^��/����0<����6�l���<UmU.n5lm���H�"|*́�zg�b��zQ�r���7��|�i��g��2H^Fv��^��k�N��0.����9c��R��n����2�˖q�Cz�����=IQm��fLo.��$}s�ZF-npOM��*i�%�i'͏�� ZՎ;���~^IE�8=�5^��%����8L��1��Ϸ��A%�Ռh�%�K9���}�U4��z�Iu3�k���hgvD�U�L���9�����/p|���\��)|�|�	Q� �q��X�ҧ����W��
�ܓJ�즧ﻐh���`#Ivu�x�~d��"Gp�x$�C� ����py��Ϛ!`�Em� ��1�#��=~9�j�s"�mV���H�wd�,X��Q�c���cN�q	���ة�AT�t<�:��$����E0�3"�=x�_�bj[�i㹴�)��c̍��G|㌟Jbƫ$Ъcs�a�x�=�L�M���c/�����#��	���t����a��-�Bep��E ��p<~�j{�Im.F�E�^Ils�3��#�A�+:�U�7�i�y��
� �$��皸�sW��5.�Jm.~�-$��r%� �< 3ۯ�Xo��:O��;|��;�sVn/1k̺��I�\�s�g�� �V�KN��H�ݗM�O@\�����B��u$��3[Ɉ�F@�A�ۧƴ%-;�w�d���įڪKp"Lɵ�^FpTm
;`gڢ3�0ܤ���A���R��=a�՛P���n1���i|�m�F'��7S0~A�E_���WQ�!����*�gTh$��n��A��3�P18��5���?ӧ���[?vC��؂�T(��l:�ߠ�8.C�s�S�z��E�<OS�n��ƶh�Xv�g�m`j����Q����dGX2+��>A0it�H	bA��}�9��z��X]ZK*3B� zl��?_�+�4=]
�n2�˴���팑@l�L�*$cӿ�{�׆[y��`���@�Y7fwY(��|k��.>�e��3q� L�� 	��?�דY����mo�YKet�Ky����x��49�=��X�Y�N�؏���� =��|�>�.WtVk��k�����n9F�ޡ�'~t� �jF�&��Z#C;��#�R�
CWnu_��s�7 �u�����I�)��3���� :t�X"��bdP�7 �#���^�Z��ՍyTJ]M(%��)m��Uu���x9��\T�v�e����`�،0�'����YV���$�ZB8f���綽��:��ٕS�!  ���zǡ����ѣE�<��F�ͭW�UI2�$H9�{� ��j�XDܞP�>�p��x��U�]��<�n�*@�T`m���r+���r0���)���R:h֋EK�JxUb��q�U�8^��ں�vm�aV����t�=�s�z�]�B��g�e�A���Z�)� �v;��7\��s�}����>Ɯ�j��ք,���i�� �b'��2ۉp�|�2����J���rH�i�č�crTd��3�{�+\j��V��S�����ea��m�8<�<�����<�lc�
�K$��7͑��GLn�LS�ʩ(rٽ�}6	���t�X�p\�X}׊�sk�
�"V�����~������3�C"2z��^}��������x�u!��]���8��:�	�܏.4c7/�1�ܲ��<}���k#T��U���F�JNw����<�qs�:xi"��" �eN0ra�08�C��3�V���pBɅ�
�P8\�\g�&���z4hr�͹�7wp�<,�C�^�q�?�>+�$� i��8 �3�8�{�oZH56���\J�T����}����m:{hH偟^�?��{RSf�)�+z�[�<��*�9������TT�u��hw�h�tc���z�<�=�I=�0�`d� 吺(9L�d�㧿z�isw���Y-��K;�� � {����SQ��wOv�)-�-�2U~�$����Kt?� Ym����J���l ��
Gu=y=Nd�p��$�c���\6���x���i�Q&��@����r
1�q�u=FR����R��,���&�,j��Q����z����緷���bl�c���i%���v3A+G[��w���1�:�F�i�Q�i��NZ"�R9�C����$������4 ���OX��'����V��G��(sԞ��Q�QO>�d(����ֹ(n�}�9 �Ht�Z�u�;��b�ān<���t�^��9f�p <��{u�� p� �⠙�(�,k���#f��RA��i��b3��F+�Ӣ�?�X�$�5�G=�Ɂ��9��䑙;,�����_rd�O\��chʰI���8d$�j��J�����d�j��nW\�VZ��?�u:+�����#.�$���l�0=P����vv�!Y�3���]N/c���@���Goj�4xy��� .��-����"�4�T�?ǁ��}����t�}%b���W�����\�SU�u^��9 ~�o��5_�������r�����f��
��w���0	�럭z����[=��tR����c�Q�r\������qL�&Mk�siZ�Ռ���2GQ��9��(<��c�jǦIummwk��7?2���/=2p:��*�Ճܴ&��+�.y�<�ש��_����˱��7� c�=��
� [>��;��rNC�Z�utQ�T��f���İ��G��A�=3Sjm,��r����=G�c�j��4�vKJI������ ��Q�|چŕB�ԹA�B�>��~"Sr��v������m=���R�p�܂x=���~���Ѭ,-$�;%�0 �s3��	�{��s#�F���d�V=A��� ����7,&5u�v��ʱ `z��H��=9�Я����E��W��FNx���Ɗ;� ;�h)��GO���z����R8���=���=�f���i���#(pq�(�y$3�2=�t�cYl��'99G���2��2����9d����j�R��Rv��f�ͷ1����=���1�ްu��t���x�I$�6}�\61�9�������O�ȾT�� �3ѱ����*����%��Y�l� �E�]Gn�iT����mM��wS[�i�'bJ��H���U��"-J�˷x��]�����c�S�Aa��g+J�ȼ�3�Vn��Xi�^�}�"|2�q�YY"�&c� ���� �?��g�w%���{+6UKp�JY5I��epN:�;���BF�ͭ�� �4�L�&ѐ}i��(�P���s��z��nNmVV�`v��jD!e|��/��-��m���W{"��ӑ���S����㸹+z��h�0���T��\���1�s��r�g�j>�'���u:��#�o����}q��^�D��Hl�6�fB��@ gx� ?�~��o�$���L�j2�����k̞\��]N��w-�El0���O�V�(�6v��#�o�1����l��"r��O��+�"�kQi�8�z�W7j$
0�Y�V��3�HH'�j�Gj�l�N)�ެ��DW���D?ȮC�^�Ss0�����3\,s<��
������ �u���O�]��\8��ɕ�~��	[�ۼ��
 �_��?�����g�֚��X�#�b�b���C;,@�'�ֺh�V���ϵQ�a�]V������{�c��{f�{e��噔��x�f�s�#�������ڴ��ӑ�R���rmX�K�_V�h���ta�9#?6G�{�5�
 �(Y�� ��=	5߄mE���q�x@�Fs�zt��{t���FG$� R{Zþ�8�^XK2�lc*z2�?�hj�����,�e,����A�}-��Y��&.���W{������m$�v�x�K�'dx��`ԉ\d88=G��z��.���j�|amb����1�X����:��1��U� ߉m�c1���C�Z�z���-<E��j۸~|�^	?��pX=��>?���w�H�`���kȰ�/s��m#�mm�-`iN���0(ZEPq��/�Z[�����'�d^ W�;���+��K�/��cg'{#m���[].w�����`Ǽ0#�����~�	FJ+B��zʌ��e��<u���g<�T�ː�ݒ��� ����]��(�' ��0@ݜ�޳o%��%���0As�@>���D��4��Z�R���!PV'|G�緧~q��B�e24oi U��8�=���\����帷�h@�	=I>��J�����Xw;;9' �o�֦SH����@R{�$�E�����A s�8�4��VT��c5�̒.[�9�M�\��EsJ�oC�4R܅�c��6�K�)f'�5��\*⣎e�q��W�j�0(M���ȅ,��+��ҭ�j\����L�-�aH�=�5/���8�x�j�gN ��=�ݹT.~nO�����t�=j1\p[h�Rqz�-NQ��&;Xm=S��7����܊�<A����ڲ����+�yQzaO�#�HٝT�tQfh�dc�íM*.�׎�U[��@A}�AQ�����A�
�ll�5���*q�R����`�c4�z�i9bNzs�5(M�޶>o�8�M��H'�e���i�9H��խ�kB�а~�H8�pΑƞg�pEf�Ϝ� �;O�Y�<[F�q�kn�Ek�Ş���+`�ߵv�w�=����9��s�ֶ����u�M��J&��R�r$��X���tE��~�Ė�c5R{6�� j��hd������L��}	�[V�NY��<q���9�nW-�� ּw��8
΄g�&���v=&W���95���Li�]�V �D�zgU����آH�&2=��>$�|��E��
W��J�6U�Z�PU������z%��e
v���dc�N?J�]��`� ����{�`�l-��\a�' �GCF��!h���"[��-�8m���F��9>��`xl;�@N��?�u���#D�t>��b�S��~K-D���92��!]X�{��rR�G�� �tK�V?�e�db�(���kݴ�7[�~+�u�Vj� �$���cĭ��kי�ZKe>`l+��z���Mf�jw�k�Je"�߉��W2�ė���mʁ���{TI�I����!O  3�=#]6�Γm]���1�������m�s��Ms���+�Va� \|���qYo∡C+�>��Z[9��BDN@����t*|��U�ɹ�'frI��V��H���o"��Z�&$���� ֮Y���t!ecN�C����ε`� �?)<CYV���1�[�Gַ#$K�1����r4��q�V�[O��e�۞��� mldww���Y}�rFq������˸R?�$*U@q�I8�L�.p)=JJ���\�y�Q�E)v}�>�sޘ�$\g�I�k{�rY�0x�`�<��<Aa.��4Lw�����z�],ٵ}��ץE�p5o��m�~����ko�6{�"�%u��W{��q�U!�#wJ�$���O�;���k]��I���=5Y���oQQL���9b�g''�ȩ�t�52NH����nm�I Q��.�=�NM^���$�0��nfم�&�7�ՆM>����uoRGL��V��U��o��+'M�d���D�7�l�\V@T�KN�H�L�(�j�Ʒ���!�������6*���ҭ5�-=�L���7���ɡ&���;k�[���&��kn�R��z覮�Y���z�ͫ�"8�<�y&��׭T�U��sY>,��u$�����;��� �����G	��?x��[�e0b� $�� ���m��U�1d,x���P�S�$z��0yEO����?���{��:�����C����+*��*��6�/K����q+�d�އ��d�ͼx�}"��ԏγo%�=E,� "�9?�ړPg_�d0~q�3q�:�:�ǈ���r͢�������=���Y�uhA���З��D,9��ӎ�+�V�f�eR����}Fӏ����]�����J����S\�@D��}��y���d��u��b�o~G�kҼ=0��v�*������ǉn�9�*� �A���_C��Z�l��[�yS6�7�|=�:Q���@#0�� �<������ZC�hJ�r�� ��֪Ζ�=��,����������]�G*�lD�DF[��FJ&��0I�@=*ݴb�9�F����uE|��{� _�Qyc'�j�;�#��Ӳ�f�\dmE���~�n��=x�Vp`�9bN ���[v߆ L�6��oCZ�0)<��nE^ ��F?Z�.�=:dP��8#n?����he�m�{q���sH�#;�n��x� ?�Q��"��C>n1ϵA$n�v؋�{�ݎe�ء�^��Oʔ��]rs�=�>��H��^A�A	�����;�i!I~xԇ^r�Tb��0r�<��Zdrʄ���j�[��[v������T8>�����!�H�j�Z9!'�^O@j�$�Ib[��y�9b S�q�bl���Z�b`C#�:��ǘ��v��5��������=��g�q�Ά��#Pn3�H=�L��[��d$�9,q���`�mS�����٧�����3Z��`|�?� ���Q���9�o�cH1`� �!�.�a�2�F{rƹk�K�O�"��A�+��!���"�;����h�f��T����l�Hd�DS�)� gH�FBI�����6�K/B�a$�nbu��=�.Ɩ�|�s:� ��c�tww�K�
�w�&o/�͵Y]9�g#֮�����-����^TD�s2����؆�6�C�(�3Q���!�0��%��t�al �� �������<���#�� XuԷ�%֍m#l+�=���]~������ uݻ=�9�xIYc�j:E�`�Ol��\_���_�o������O;��\�"�Wm=�������Q�9�;mn�[���!W�<�Żc�~~�$�IE�L��U73t�_F$�?�W��,��t�h!���ь4��Aq�ldgه��ǈ��/i�$�k�ͼ��~Vvp�� p:�5��;X嶴��k,R��r���{�����q�qs�^,��]��#��� �&�KK�t�>�,sD�cLX�1�S��ӭmR<�h�/�I�d�!�\�?��޹n|ҿ�һ[y|�Wv�U�y܌d�݀vc�q�ג�6Ž-\��ci�6@ʫ��$g>�On�93�s�T��YO��H��o����#�iA��T��t>���jM�Xʖ2����(�4�qΣ���J��0��ֳu?�\"��� _��N7V�j�㟔���k���livL�U���k-���߹8��ӭ�**�!GA��.L�d0H�|�4�E�`Q���ʦ*�
��А{��Ʊ�Vnz֟�'́�=;
�|�l�\+����Nڳ/�F�!�h�[L�Q���E`"��v�8��4�!R3�	�i*�+����Q!�[�<w�z��/�r:{բYPmH9�?�Q��y�O*z�T��m .y��y_99d�́b?61�j��l����TrJd�t�d��V6I2OoJ7yοn� ��<z`V)��%x��uz�(�f}���Ƿ��U�g�>�)X�fn������b�i��'����L�ʜ�ȭ�+J0�^����ⅷ �L|��L�	��,&[n"��$0�kRX���<����p2?M@4�.V@��|��"��g���%q�]�$`nv��Q�q�; �#w/_���.��mǔ�}�y�q��q+�񤌤o�2��oҺ)�qo,/�J͕(8>Ʃ�Y������O����&�a�D���8��특c-�庠+��Q `}Ec�n�q�@y!�7���m�-tf9=A��S]M�gV����5j?t�E#�˕��b��Y�cYX���}�⦷�i-��S�߆�=?��t�7����W�|��F�ĺ�Fy5�j��>������VS�Q�`z���XE�J돻�+���y٦M�l�k�D`�v�hj�rb��tܳ��y�Y��ib܏��t���@z������F��@q�@�H''���}�K{� �ї�`�9���7>\���W;�C�'�ǿ� ��J���R{�]�ݝ��]�g%���=8Ư�3�^����L��1�FO8鏡���,>�Dct:�!Tc�� {�'׮:���`p���W�1�9�ɫrV3�J\��9�vSg�̹�9����~Y�3e���]O�.^+�mO��YT�s���:��I27+�¼�gfΚ�v�{�Xm2(��>�'�\�.�v��ɬb��A3�!�횏dJT�+��M*����4Z���A�bw(%�=��uZR,V�^2�#�Ŷ���W˓k�0ݫZ �ڈ��Yr�)GTk3aX�}�2x��| m�`e��5�oy�T�Hl��MZ	!&&��Ӛ@����0�$b�}ND�_�ވ�Q��#��PCk3;���rE;����]F����}+Z��,���V�U�N�[$0��w��I#6�/��Fr�#Ҩ��#e �)�"�;�^)�|G�9�vd���I�t�����7;@�z�8\��J�5��6H��:,U�l��+�6t��,��G�x�En��  t ?�U�M��2�x�4ց��f�ԙ��zs��� Z�K���4�c�y�SK���G�Nӑ���~U�jҮC&���5�њ7tjCd_���D����a�L�b�K�'����9���sW�����cdm�(��EDP�$dzcҺ����=��'�Ÿ�^)vDб9A�=�k)��K�����9T��j��kú5|2� 
ܒ%F#e�8��������fhbM#�r�$��J�x��~�;Չ-�����ʠ�g$`������F2�����ߥC����#� ��Қ�K�%�İ&"0��@�b��-��������Z�)W�v�0~���Z��.d����c+�&c�%�0����`u�q���ѴQ�b���<o�=j֑���� r�Z֗KW�fa�j�`�zά���)�D��W���<��.��]�N8�@�]k���f��ǦW�a��<Wi"DDq�9�*M�U���2���ĳ〬����?P#ʬ��:�]8�lr������&)�h�0=@;� �z�h�MO/%Mh��E���sY�XG*�xa�8�O� [5�Y^�ݡF��p9S��s޹m.x�^�VL���k��fk�������ف<g׏��ޮZЛ���1u��&�V���u�!�;2�c�P{?
���PgՐI�k�̊�(�d��B I>Xs�M!���,?���k\���K�c<��Y��H�j)b@Dk���_�Y������rzVe�;�!2�$뷷s^}H{�;��8�I�;� �C��=+I5C(Į���f=�2��*��q���iYjv��bU�� $�?�֒�.U#Խ�F�4�'� ���}*�-�FЋ��~��*yn�J���nH^zc�����8�a�EU| *�&��d�HܱJ�3�O5m$䍌��Y���[�G��=J�:����D���8Vy��6�UH�МFx�O�sVpFA>۫9���!�����߭D�]>U�T���T��Y��a�;���Θ5	�9
;9�"�@�,��OJ���>W8�?('�5t��`��I� ������1��� �.�����������%6� {�N�VGV��y.�횳�r��Oj�ƻ"������>��1�7��Dc��?:�؜N�H �r�� 1T��H~ki�3�\d}8�vڎ`W�5h��0l���k�k�$ˌ/R	�Kmx�Iޭ��NYD���H��@��&-b�}�pE5"���c�YHۉ#�=k.;��a_\�5ee%zg�ZZ�Ò� +��L��]��i��ݡbx��?_��4|�Z�c��=)�4.s��t]FfP'���*�fmCw�&��K���^>��b4h������e˧���P㒤3���B�o��z�T}�O*�Q�HwZ�e��V���yV���JAY0�� =�������n�/��>)��8�zVe֍b%{
�ғ�l��V�=8��ZJ�zR�S�����ıD��kεuB�ڤ����D<+n���s���U���#�}z֡�t봺��2��� ���<����)&v��z�.�moEU'��U��_H#H���1� �(b�'����Eq�ۖ0w��0
�4����8���V�|�h�5;웘�j���
ݑ����V%մW�wڢA���>Qג}����H�>�����o�#���wQ���̭nYMm;<2����;�p#��� ꮔ��9�4�'�5-�T\ �7(zw b����.�{��tQ( q�9GNEy�|��d�D�� ��?Z�|3�*\���gϖ�2�s��G8��4����ΝK�=�%�s�Ϲ5.�����q�x���d��N���c��sM�ŷ����H�=ɤ�E#��͑[xZ��!�rѪ>J�䞀�z�bЬ�ⲉܝ����g%�q��8����A��]U�qTIso&�����<����*��1���s*Z����ɦ?�4��[�g
���x�WE5�j>R��d���d}ב������)E"��"� �x���>^����|�`�ԑ��Є��c�[��EVv���!F��ff8Ǧ��V(��4UPy||��Oh  � ���]�I�,�$����+��G�;�x��.̱ �~�v�H������vk*�@`��\��	,��h��8�q�߭hG;��Cq�t�ɉ"`�@z8>�.jl����H�y=US�Ԑ+:���+��m'�(:�ַ�%�m�i^\u��mqx��ol���~�����Ŷ9mB	l-�y^�8#=NEf����d�hz�W�ӊ��t�<�Fk���eͤvM�]�����x���i:F���89��m�Xoc���Q���Ǿh�v���?Qһ�>�U)`ʥ���#�7Zdo6čR�k1 r}x�Q�nL��ͳ�(��GF8lV����Ӽ,y�� ��YW:r�:đf,n����x��C�@��G��R��K1�{3un��U2�?��� �^�ԣ�ʏ���!��÷K��c�e�pp2s���u�	u��2�w+ǒ��*\$��R27���\��z�j���ҍ�H��J�x�Ҥ�ȯ��r�g��N,��l�)8�'�zS�h\������q������2s�V�5�ǿШ
=O�u6`.���c�˔�6==���O�+�`�#����=�ҵJ���Yױ3,d6Ҳy�H����7ЄC5��g�t�F��|��� ��7	����dB�����,Ss�����}��y�،��֎byIR	����΍@.�~a�A���)���ͧo*�F�88��޳�SH�d?wv'��{qP%ڴ3� #���������gj��K/˵H�
�99Uǯ��K��xՌ{���;� ��'v=G=냹"�^���Ԯ�&;�g�~U���Y_p8��<
r�%���,к���T��^k�,Ma���k�������GFǦ1�{W�Z��>O�L������|���=��g������di�o�Έ��LF���u�����|��K&�Vx�*�r:�~��fxjU����!T����Muڢ�-Ж2HdS�1��+6�c�B7� I=O5j;�H´0ˎ�D@��R��߭k�ktv�^�o4�<��%lG��s�� ֫7�9�(Q� �X��ԏ���C2�X�O�BU�d�;Uې�Z���;�
�O�L9� =k��ų���5{{��L�$%|��}3O�xRb�)�H���3�Vci�5��!h�2�U��2^�����5��]>)�8<w�R�{ӯR���:���[Ux�xl�� �鞕��N.���|�����?J�Q!i��&el�.�=� ���b��5��H?�bO�=����UJ	���Իr��]Z�$q$�$U�~�?_sZV7v���ɸ��n9ӟ󚪖WR%㬌
2~_\z~�ޘ�ч��'=�zRiZ�M)7�v�sm1ě�|����֧��xU�2�s�����O��-�L�Wnx��O��T��e2E�l�Ɏ��0��5���n�Z�DO �P4�p$_�����U��&��'��]X�q�Fy�Җ#p�̚3���gq���>�Qɪ
a�"�&�Q��p=1�,Gy�=�vOr���G�1W+������N=�<��w,���&�\8#�O__���������ZC��s�q�``V����bU�y#�������T�6��Ӭ�����wK���;�W���%�9E\�g�{N�������̭ ;����#�nq�<�Z)d��kA�QH6�I\��3��S���^�%���&�I�b3�0G�z�&�w�cTo�cB���f�D�ڸR�2:�V � ϰ�y��gIf������2K��y��>X�Fe��i}@f(w36S0����;�ڡ�I#����̪Hc��I��x,zc �h[Kƞ�س�{�[��?
��DD0q�������N�Y����2)&���v��G��қ5孬h�LĂ���׌���5�x��6"��.� ̣Ӛ����%��$� HQ��P�z	Fw�z^�c��%O<�+���F9Ǡ�}�m��2rj� ـ`�p����cE+��
{j�+d�Ѓ�՘�ԩ��~o��l[ky,T�Ё��k�܇�`6矼p?:��ن��9�ڰ\���p�W`�1�� dz�� ^��5_��UI��R}
ŧr�4���@�`nѕݜ� =���~T�Z�Ϟv��3���N3��^��Z�[���ɍw?lt�~��V�Oֵ+V�8Z������6������hM�5�[|�6���vV0Wou�^'��V�A��P�j55�:5��U�[�L��I�	wGR�`�������@������bpp}��5�1` _��7�����/�p����F�?�
?
��Dւ��WG��{��#3���|��l��]Ԍ��&����f�}��W���qj3JIi�is�?��~��:宴�dLB�B�����^{W4>$u����'�}�"i3�]B=og�J���0*�7�q�c�NY���J��A�������n��y�����q�ۉR3�q��u��k-"2a�!>^:.Glc<��JiYo5�.�i}$1ܤ�ʐH�n�'ӷu�L��9�{��tl]��2���:��ׯ>��J�<���U��`z����#g�H‫K��Qב�ǵR��2t`��ћ�Ero��7�W�G �	�<�C�Փ�j��(��G:����A����]ķr�E$ ��ꎻ����$��i6W�1��eفl$�&3�����;-L���x��7���R�`	�o'� �S>������N7n$�X�
ꎓ�D6[ڠ�՘n���8�Ih�J�E�%G�g���/ht��V��nd�[\(t�H~R}��9��V�g�fyDe�T,���㞘53�8�Q�h~ֹnX A �s�Q{��Э6�#�-㕙�!Q�A=O=A9����E-���ȡ������}�l�J�U�,�ɹ�oIY��1���5V��g��YQ� �l���WX�:����e�5)m��_a�+*����^�G5�q��"�C��&7D�u���T/.���I.a��#��R
�����Əe�B� 18��:�ܓ��:���a�Im���� �O���<����U���x�ݣ/�Q@a����s���jV1#�� ʡ�˞{q����K.�2L��&^I�� *[���d���'�R�3߮Oz�u1��f�s.�ݎ��@'޸��lG�1�
�(��Q��폭-��g,� h �%3�C�s�ұNK��Z̳�lFFE,7�����UN5���\�7'8?�+:}R[P���X�,2zLz��kX�B�۲�8?�9���?�T_]cu&t�vɧ�nѲ|�Y�T�Bz�s�ڸMB���8~����^$�m�"+.>~q��o��+��|�RO^Ny5Q}����j�{�ۼy�ќ���dͻ��v�&��X�y��� ��|��5��E��jYIf��ҵ�ɵ���Z�"jM����$�3��0I����]d2�D|�U��W1�����	�eBX+*��ʊ�<�?R�d-mh߼�,�j����;WU����׮���ɑ��[��V�ˈ�W	�7>)�0s7>��$�6k)6���G���C՘�O����sT�����>bF+���d�93�T� ZěS���9���I�U�M�]���l� ��?J�<'���,�2��;��?������"���ہ�5��Á#Z�t�o��oNMhL馏^��|�=��p���v�<y�E�
YX1�O_�k���?�z8!�� �rz�� �\����#�s��t� ��>���i9�jD ֦M��ԱǇUfUo\g�������7�����[{�-�Ya}�*�oȏe$N@H�W4��f��<�I9����� ��Q�{~B���:�i�Е�J��6��px��bEeG�]���{c��TV �{g� O�WLѣ[a�\�L��	����};w�M�7� h%�{��@$s���{}@��s�#rQye	���<��.p������8��B���;�^n�z�1�+�����ܨ ���Olu��>�����[f��H�#���zrA��\v&��6��|���̍[�qӶq�Fz�ަ�E��c�tX�|1�L�d�߉�ld[�3F������s�烜�5�k<V�,��.�8*A�g'�q�`S�X��IN�d|a]���ϡ��~{؄�4�6~�Xg=zWy�;@�W��r�0$c�:����Q�w��0Yb`�>�;�q�v<}==(z�EE�&tڇ�a��'e^���o�\����W[�`�3��G `��~U-����l�g����ۚ��e�(�X���8<��q�2��v}}F�R.�6d]�W>��5��O����q;T2x����5(�>q���k:K�y�,�) .O֩��B���:������Y�$<�} �Y��1܈�-���S ��Z�7�H"�[�1Gߨ� ����@��(�������-S�,5������LH�Ld�����E\���n-��w��L��p����+C7�Y��9'ӽ/�"bM����h��!&���,l̼���G%�˓M�����jS1��m�Uky�������*擩}��x�R�z��[y�T�,y��+�X��~�`^��A+{���O� _��V|�ې�t�$��BO�=t��*w�p�
P{`�Mt�e$:t	��b��Õ�n��v�e""NW<���|7{��qG#?1.A$�9�0���X��#���~���dD˖�cuk��T�j���}G�(I<*�MyƱ��˨H��T ���ֺ�i���q\���;JS�C�?**ZJ�FwcW�r�)o�*�$�-����?2j�Dzո����Q��E��(���F.A�0?J���0u� ��3��P���h��aY����y�'�BN{Ӊ,���� *a��"�H���H�"��f��#PG�r���@=�v;�8��ڳu�4���V�у"�B�d~4�M���D��I���v�2:���C�o�wm�(=$�6~��5��Y�<," �j��8㎝x�����l7 �z {��z�4�%X�.����9����;�f=�����)��X�>�����L�\�վ���aM��I� \W�
(�npt)Y��� ��?�WM�}�1EHh�u/�W��_������?,� ����E8�'��?�|?���zG޿������lsR�+4���ڲ/����j(��Wb��?O�t_Ɗ)3�l\���N?�W<�:�2�]w��H��]EhX�?�(�:�E����QEsN��?��I�_�WB3$v�^��E�B���ҧ��?�?�QEOR�E֭�E"�Ņ�>�*� U"X��Ө��Ч�c���������QE [v�� q�?�?��m� �_�(���Ԕz.�� �?G� �k(QEoK�E�c�ٮB  4   �� D O G S - 4 . J P G         0           ���� JFIF  ` `  �� fExif  II*         >       F   (       1    N       `      `      Paint.NET v3.10 �� C 		
 $.' ",#(7),01444'9=82<.342�� C			2!!22222222222222222222222222222222222222222222222222��  �," ��           	
�� �   } !1AQa"q2���#B��R��$3br�	
%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������        	
�� �  w !1AQaq"2�B����	#3R�br�
$4�%�&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������   ? �/x��F�⳶�Y!fEbrK�z
���'�{Ak�@������+�N3�����j�f�����Q��Ğ3ԑs���� �Vs�C�2V;[&%����'�����B�
�gf��Nӹ�c��+)6m���?��d6 ��o��=S'��I*�ړ���U��ڙ�]��n��8�3���j��!���z��hl�@��� ��[�z�'lV@���� �UVu)��Q��+� ��
��7�/��}r!ŵ�����Ue�|LסZi�� ��� C���Kf*]�O��dj�,�7��$cQ�r�}r|`�U
�=;�s�� C����B&e���/��� ���V�����GA�2�8?Σ��4P]�^��6�~�({{}gt����QR�F�����;W>?��� �?E� �2� �ʿn�?g��q� ?�սx�1['t(�;��h�8x��Q��H�ޑˌ�c}OƏH��e�zE'� �#�����!G#�ں8�ɉFЪRp+9ɡ(���~!F�ش�q�I� ��M��@dYi_�2���'�#�ާ�5Tl0�<ԩ��D�x�2k��Z;=3#��'� O� �����c�>_�e'� ^Ue9�u뎄V�Q��\��⚓�.*�p�|G����E�� ��� ��I�{��lt�ޞL�� g�V��p.1p�1S�X4�gN8��ⴻ2���<W���G��P�� �*���%��Kts�H�� �ε��f��.��W?y��F&��ˊ�����Y��K�;��M������� q�6a�\��;WS}�}B�V��H-Lq��*� 1?7�x��r_▐ǩ���%t�����}P���8��MI4����4w�A�	9^�]���,�!�T�)bwGm�go�P����y֣���+��X ��������ŏ*�>��)Ҍ��f��������ݽ���Rh� ��|Ov�z,R�8�c��~�zx���� �5��R�z)��|�/d������ ��G�>�F��YR-�� ��<��'��'����ƣ+���|�4�@���ϗg
��H$?��V���.r�p��(�dW
uIr	`G�Q�`�6O�n�Π� *9a�9����Mm��F��@l�BCS��O�f��ž�8ʣ��������$�r�e�y�������|V�%!!Y��v:��TN�m�^]�@O�׏{qn-!O,��Ì��?�w�3�Οmq 
�Į� ^#an�Z�⣨�]����1^դ���2�x�A�������~A��)���|pOYǳ+�ebޟ;�g�۸c8�W|[7����݋5Q��������+9+D�Z���rK<jq�n��V��+[��G���;Sn#
c���'�?�:�%�$����-����egcIj�i[[�*�= �V�C��5&���x��J��rH�I4cws=��0�gި\FɆN��Z�"8��=�Z͖��"F��C��+�����yA�<)�+���'�7�k�\GtF03R�B��sZ�1<,��8#�++yV'�YNݸ����]r�^ ����W���!�,��ʑh�"����|I����d�}���c�쨠~��$^���g�緯 �۠����!|�=�T�d��5�[�s1�lp>����H8�=G��Emn�\q�Vz�3�M�L�(��;UK�0G3��k��]�-��9�ڡ:T\�vi�#?1$
@rqi�I�G+�� -k[�^C�;T��9#Ҽ"(�'�J�>X ;ǡ�H9[(A">f�n�r1�85�+��1��L�*���榼����>S���p?�rz����<g�u�\z�޶��ؘA7iE��x�No�G=�|�}��\m֟we+EsFGL��5���F+�����f�	�:�<Nm�V���n s���M�r�C�0� ���� �o�%t����,�$����v�:$��s� 	��:>?�� 藮��ky��z����m亘G�%�1��x������$qm�� ��c�jMIm^��d�T���y8��={Vi����g<�Z�)�N�!� 5���vmÝ� ˯ֶ�%{�]�B��Wrf�Q�,M���S�6���E����FperrGb��Z���Ww�˴I�?�T�u���Hb�F��.������eͺ3N[��;	N��<�Ys��ҧ��@rc�c �袶��"����� ٩��-Du��� �&� �'1��O�!%q��>�Y3� �U������K����5���+��Kh���5��G<�sL�B�#8A3q��}�p�{�L���+���g7aՎ6�mo�s]��|1�Zi��Z�A��H�E�m?61���9��7Ē>�kA`��=�~��]��T�?e�'9��*kI��5u��� �|�$h�`C�_#rA���"�J��t�+wff�B�rI
I��1S/�J�NR��Q��|U����� >�� �5eJ��!N�kG��[�I�ź�{nj�Irzm]}J��!UIy!�n���^1��Q&z =�Y��ǀR�V��b�����ұ~�5K��&��d`��Z��N	��#R�1��'��K�x�K���ٮ|K�@X~g�Z�k��N/���0$񊩜�`���my���)22��Ҭ̂L�֢[�8��²!���p��/�� �q]���m��g��+��.�F�b0�/<�-E�Q4a�TO@?�f�/m���v2>�rGlu?�Ҥ��ʀ��C��2�� ��fx����y6���d}�$m �?�j�k钙� g��`�f�c��z�|ƽG@b߳����Bi�c����6��t֌�<(���P���"�kD��q��'�V6�1�r8��ݢ��w��<�C�2�3)� �8�.��t��O?�\�g�<��3�*8��$�@�� Y��;�Q��ؔ]�&׍�7\�ӊ����H����?vq��^+^�������z����)Yhg�xx�Y� ��k���\� 2ī�1�����Y��q��81�J�.�׫�w1Gi�}"�?�`���2O^��4��]WmO�^A�jCutИEĢ3�7pk_\�E��$*�J�����~�k���ȵ5tv	����?�� �/]o�l/��EP	��l�CmFH<�ֹO��� ���� �o���:��� oM���dyM�vb�}�q������O��������F"��eL��9`N}:f�6Am��塕@��0���;n�=zl�v��]+�/�"@I^@��k ?z��i��z���d�+kc�
I �s댏`լ<�Xa�g;舭5+����:�sb����?�j9q��p�yc�bG�k��XIK/�&r!P�	$���Y[��1����:g�y�g��s޴r�Ղ�{��T9S.�H8�$��?�Tf�~���kZxoG��>�ڠ�UlB%}�؜q�����j�,����_�*�i�"$�]�_J�����ԯ��A��o�~�)�����-^y�ӝ���s_������]BV���4��a���*���P�)?�+g���i�sjzո���.e3�ǀ2���^�C=���f%���� �k��+]�gM��b�	0��p�)���sɯf��2و#].��z}��c�� ]eU]������:w$�d��S'(���Oɜb]q��+����Z}��lJ�U��T���L�o��͏ċ�Vx�NM�� ��sSY�=�H�N��
��5N���Ť�c]:6d_���j��K�w����tl}1�n2+�:�UUd��čǞ�VF�j� �q��tP"M'�߻^����*2�8�jY�I�w��R��T�;\�l� �UmgZc{�Ʋ\�|�L�w��R���Zѥ��#�{�5sH�"!.#�Cjo�=j`�k)��<J�+����9P@��k��EP�Z�آ  �,qջ��8�FC�A늷�̯��>7]N]{ʆ9�w.�O�h�f�
���u=��^��Zn��M���a�����qX�e��#%}O�d�&�8���c2IڙR#�fx�}�O��s���>�n���1��
�rA�\�����Kf������:c#�(J�j����u�7���� B��3ۃ�Z��߳����4� Э�ͱ�;ֆ����:��cV`�A dL�uga\�㱮cHҮl�#�C����H#�+���W�6�c�Ĥ��E,����2�H!�]=�:�� �t<���ڴ�J�-�s���E>���l,pG��L�L3fM���L�7�	 m`����/�$�'����q���k��Ax�E^�?N{��ⲖQkj�)�x��z�U�Љjw֫�XāTz)���*��1����2����V��g ���*���=CM�F��HCmo4g�ǵo��c�f��;�NImQ^TpB��	��\הI���	��5����R�Х��4g�����F9�&���B������@� ����o���3�����wx��w2�rI���^���
������ D�z�����'��kJJ�>/I"m&��/T�qA����+�<Srږ���;`4�lE_�H����k�ok<���/��f��W�-��&�Y��m��lkEk�j�p��S7��L���ۡq�i/�Q�;�s�z���X�@"�>F�yPyw����x�h�G�"��O�?�����N-tr����0A�+��]|��Ks���ۤBh.%O6Lu,=���:s\�jW��~�pB��5m����I�DP�p �A9����4�LG��#�]���j+�ܒGy�g4�Y���S۳D�&�6��3Ki�k�K)�8��o�?Tq�V2yWqK���ô��|Ȏ^���n-�6��ev�q�O�{ٓ�[�zV�B�$1���J��"�F�ae�����k׼5����������ƈ������"��R6�FU�F��d��G���2~��^�Z��ѷJ�� � �Ep��;1��s��`�c]Ο�  �_���Q=����?�:���� F�U|���k[d$�� (�����=���U���:0O����1v־lQ�1nR�*Pr��"��8�z���Ci3�X�/p�s$�ى�q�[z���$rb�T3�:���y��y��Oe�\n��,î2z�u�/��&k���C����?�4��)֋wzx��tn<��Gp�I���=�� ����"��o���R�?�ބq���dZG.� ��8���OZҌyc�ω~�J���
�WO�(^���Y��K(<s�~�/�iUY����S���4���(�c?{W)i�<w��71�6���c)jvR����B������99"���.!���̷�[�u�@c$c�9��]XY��J��C��GRǵf��x��tk����G�9��Ży��Ĳ���[9H��}r;~'�W*ɚ�t�c�<2��L�&�~�����y�� W9 ��v���%�����>��{K����t9����]JǦ���� ��Wc��"2ǌ�� �[Y��)W��i#�K��uL��u��o+3�7(��3�v뻶9�n%pά�*#?�s�&�x���0<�����t�C�$�-���O�Ɗ���<���0"��nNsК���8o<y�3�
�幖vf2c=�]n�����sfV��e�Ƕ*[PՎT�64E�����H�ֹ��>������+����+(��{�Ҽ�[���V��me�0��q���kD�W3�ө���:�����ǭuV^�X&lL@b۳Ϡ�ְ�+&���r�8�v�RR��ԝ���)9����&���z��z�aq�-�?�ʸ�wZ�/�C�.V�H����%��ne���恊ȗLA*����?�G=H�b ��o��L]�ش���I�9Q�2�s�^ߍp�����e��NG��.���.�n�01*�|dt�;��^{���C|V�#(�C$��+��3�q�YR�w�w;q����F�i���̡��q�FW��Q��� 8��Kx%�O#a�1��x���>�M�Ia�kr�Q�h�����{��yҀ<�
���*es������O[]����_�#�,g8���� �ֶƗmk�����@�*[�w�9$��Wl`t��V��P&=��cF����K�OB,m��T��J��nq�+��f����[H���|Ȏ>e~q��5�C�]G�B�����,eJ+�x��\����n�λ�e�N�p=�~��z͹㶶���Dѩ�R����h�������I#�(�Nx�ȫZŠ�BA���8�p��+��tv��-��\B�P& r�������:�N<�=\^�D5��y��B��s�n�<0��8�V�Nt�C�0�A���Pj�z�̭r��EB!_Ǟ}k����"�������^�$p�Q����$�m���|wM�5���-O�-y��-�q��,�����^���UO؇���� "I^s>�eP�\`u�F)E��'Q��Z"���`1;W������L�>�TbxZud�*�^�5oo��1�OaҶI4q��3�s��8���z�qO,2W����#�b]C�ɓ�u�+�`�GQ\՛Gn���gS�Yn'���.#1�A��� ���㓕2Ǹ!a����Yi�E��Bt^VN���g�$l�G��``,�n�IY���!(�[���ɓ@�X4��=6�~t��؂�o�T�������}�N}�mB��S+Q���Q�W�$a��t��6Th��]I{p��y>�X�8����{P�)ZǪxlg�y� � ��;z�P0kѼ7� &��N?�$��޼�(��T����x7P7�Z�%���FF�+2������+��� �u�2@�_���q�� :��V�>̻�&3�sǽ;]�s�\�k���s'�C�'������Z����W�v��8N�H *��VЬ2��;.�)�`A� 메���sQJ�@��q�z=��R,΁�l���g���R��Ԯp9���C� �S�UV�`�߽s�jV"SR��-`6�ѕ<^���Y���F"���<��u{�i
�����k���o��|��zc�5�X'Mߡ�	5$sP�Ӧ>{� �|�8�SZ��P��xw �a��g�T[�N�,��ٓ<c�d���UQ�)�h�y��q#?��<��uBqN�����O�v� �/^���[ǩ�^���n$�������{�מ|5�{_��d2����� �/]'�on'���#1�w�1�� Wu{�b�i������ѥ��(H��~�m��{�=뎶�������Yc�6%^&�����(�.�*.`*7 � ��L���z�`��q����Zݨ����Ζ�9�K���BG��B�#ե��W�� �"�Њ�7���7��Z��ő�lc��� �Q��H�:���|w�"Aе��� кWC��I�-c��b��u���� ��RE�3c�o� VU�Gq�r� �����~����B}~f9�*'��}�Ǥۆ	�C��p������I��?Q>�$mb?�Q�iZ#W7�o�ʺ�k���1B�da��ܟ\V�����L�[��)�L�HUU@^��^|o�f��۾���j͍���,@��"�`�#��¢Q��览�MZ�t�Aqs}q�DM�g!�'*8�=�s��L�?�a� ^�� �"���Z�:v�md���������������QE��*� Ⳓ��2��������_X�u��~�u�"-��E̐��<�=�Ϳ��@?�/j���e� �k�F�{{�X܅�	]��5�3�_��Ǳ�*��FD�S�Q>^� �/�I�xwWw2� �5jx�T�c�  e� �k�G��S�/��F���2���� �8�*��UeN��V>y�🈮-w� �?�o\(_�ɟ�Y+��q�d{������V6&s��_�ɪ�JT�>�nCl?*sR��4\h˙\��O��d*<7��;�p��o�!�(�?��1� ^2� �5�3�]m��k��?«>�y�d�ؿ�X������!�g�?�Z�=� �e� �iS��'� �oX� ����z=N���J	�P��*O��?}�� d�/`���#�����Ú�� �� ��G��)<� �5����M};%��rܲ�����f���Ԅ�M����g�SXw�O�y���k0|���4���e��{w:�B�$|��v>���	x�c�)�[�  �� 
��뚞���S�,����!�Z��Ȁ�A��^$� �t��8��$�Ee+Eٚӯ+6��,|#�V��A�#j��@ds�W���w���\�u(r�ǥy#|[���q֛s�8?��A�ǿŭ0� �8?��\�U%)�K�>��/G�tmRV����ʳr8�]����^i��i7�\:���'����r_�i &]o<��������Wk9.�.�"y$ ��hT�&��-:.�$��M�S�T���I}�kwF�iw�'��<��=*]{�[C#���'�q���
~��3�W17�?Ƀż@u�n�?�i*]L�]N��k6�C�&���-� ӧ~��}��z���ߪ����t8�aE��Q�!��t�#[6�n�m��՟��L~EO��+�*I;��k�Cƺ.���m���
���\�]4�P`��e�嶴_����#�3�� �*&��(?.����� �c̿hV���C�"���H�`�]��l�<�Q�FaZ:拫˯�2G���]J��n�0,ps����/�v�%�lt�*�+���B��Fo�0O���'Ğ?�叉u[kK�V�ɣ�E�l!FJx�uR�����is���l����F��5��`��3�qȪm�/�D�� �)?¤��=��ꮿ�YB?�J�M����Su�}�,� �I��%i��Ġ|+�Q�B�� �O�&�x_���O� $� �k������)���3�0�x����Ig�;��Y)�0 �"Kh�	�^k7]"�s��x��������������������'#?�G���<Y?���H~ x����7=1G� e���S�� �[���`:���� �ӗ�~%9·�����Mu����ΪG�m����O>�!���>����/�!��O� ��&��v���*�zO��-��-Ui۫���_~G&�Q�Վ�����52��ġy�I}�".�������V��v�̥ƙz���Gc�?Q^ݤ#Ǣؤ���oea�ѐk���"�:���v�� ��W�g��F��f�,�����UOD�+�_��:�����|c#֭��n��SY� ���q]P�Ni�G%���;P��l-��&E_��Cc�� f[�(ޞ޵�x� �s[�˪��J�:�V� \N�4�\þf������^*�kFH��L��z��*P�X?��z��$
%�S)�%''ڒ��ڝ�bSr�2��uaR�	n��_fz����ˎ ��b�k�m>#�1m�~ b3�º�k�V��TH�<��5"�Fr�%�5^M��ڝ������B����s�)Uv�X��U܋�pm�⅕dPp)���I�Q!Xmi=������'�7�H����u���<���_�1��V�3��/�|����^n"�硇�! �}@�F����==i��X��U
��H��\�έ4,��@3p02{������ �Ee��!h�Ӝq�X�?�q\�(�L�B� �O-�<�\:*�M5�rמ����v����
0�@��w���$���eFF����Z7z�+=��eϚ���9�����s����##����P�9�+��'��}J��LӁ�̢F�����=:�B����o�RA�ӡ�
2��ě�6�b� ?OZ��V��`�@���<��>�=��Y���R��v_�������+ֵ++y5k����NG�F���?����bo�%{.��u�2�w�<���z�b�b��jAP��|mg��E���Ϳ{D����N���
Wv�����U�?n%���n����{�� �Es���]�U�IY9U���wI�l�z��<7�;�7�I�m������Q�a�I�e?퓎G�h�&vQ���� �?"1S��$c��?��1�\J�+���d
2x^8?�t��$��s���Y��
�$eq��~(RF�Ý�������* d_l�_���J���NFW={P�>L� n���FUo�c+�^�� ��HԱ8]�:�~��*���Hob ��He�����@㨯o��]�?��/� W�FF	
q���˚�=��i�d�� +Z;�H���d�B?����t. � ��kkQ��c�k�d!�^�>rO�fo�'K�
�A�������f���k���'@�0��׶�\B�U�-����MV���I4.��GY��z�w��o����7����ی���m�Agf`�P�Ps�ºR��ӤuV�r�bAɬ�洺[��eR�<w�zW,▗:c&�0/�.����N+q�{�߆�;ϴƖ�4��"��k_۳@Z���*9�+������ �jL������4ӗ*MF���IՀcۥZ�$�sҚ3 ���j)�d��k��.�p��u5,'��s�UR��ϧ�-��������LFw�#� �[����lU��k���Z���_��|�[���+Ϯ��w�~�,�ŘJ�_}�1��
;֤��\>́�y5�awcyN��j�3� qS[�=����:27�q�kA,3�;�� �e��,�Ò9RC�+�܋C��rԥ����f�,6��=EH���wh�1>xh��V�iHb�΂M���N��1�5�.�Pc��&���Ʊ���ء`��bu��;�A>�=��Q�L2�l.s"�j�ֆ�hW=������Y��ˉ�c����3�MU�:Q4��Cw�*G)���B�i�Vk�h�7�B�I��'���?��Z��T�x��-�mR<����ִ�Nm�O�S��A4'�=��eo7�a�'�|���Y�G�L���q+�����U�� 	��|O���|�.�O�H9���5Y����� ��� ������T�DfU/;���W������^�q�Gn�l���s���ֻ����c�:�3�+˼l�O�琨��2�?ưZ2�������ی���Y��/ X0������n��F�����N��C>r>�?�4�;����Z�r��Z#<�ث�ڬ2�!w,P�
H`:�G:�����f��p96��Qw�9���<�;�t�%��Lcp�9^8�����RD
6� �@S����@�220{d�OO��֬( �sѲO����+63N1��I���=��ִt�m����i�S��@p�_R�{�^��%�#RF�w}B[P��Id���iN
Bn�3"(1Of��X�R��ñ�����4��,� ����KWP��T�;�ϧ�kִ�t�:H��N�����ڗ8�sT\�y�#�j]mȼ�Fs�t���I�6pN;W�o�f&�}���C�t��7�ٗ1�vRW��9G�^��^�Vm;.�߅y.���ֲ����G���3��v�� 
R��C��-���72�����*֖�w�%í�2���?8zg�޹������Hw���Wv�Z��䶊9R$�}�l�v�:ҺJ�E�BX�NG�Һ3T�K�^*�z�@�kn�Ҫ��43!�3�͒MX�kɫX�fr��޵�]��Gb+�4�rK	�x��8�z旬Ǭ�$��)b��*}�B�nug��^�#���I^`A@p~�J�6��Z(f2nc��Z�X�4M�J�9�/���|"׈�a?�*��z�����t	�K� H��X� ��W�+c���]�l���\����]��t��TF[�/��B�8犱�h��_��S�Uv�����egsi�Ս�Ŗ�K�E�$��!��O�U-E� v��X����{~X�RI%� \��|��F2?�Xr�p�"�ѩ�u�	7x���8�Ҋ��vh�f&k}���٬h$wv�Gm�K��������[A��L�n�jeҴB�Ē�2�`A�n���[�<E���Et\���I`{g �S����I���7�����G���3�w]�H� Ǉl���-�^/:�7Fs�dU{܏l���Ѫ22_�ϧJ�Ԑ�%�9W\�9�+�!`pX�l���&��ớ|y��g�0�J�%V��� �+��������dg���Q^��N?��P�]I��NqӰ�� �\O��-��#iR��D܃��d�����wm'��,�C#K}"�ߴgq9?�ΕT���_6�UXd�#*�sP�:m�7�$6���8������\��P�=B�ə�g/����*��5��7�ϔ��� �q�䨹}N�V������g�9l�2)�X�N��N0[F|���q�,TV�$�GtSh��z
����g ��̧-��H��kc�6�HՇ�U�s�� ��Ii�8�%d��G�t�L�$�~d��s�q�w�ڥ���j`��mdg�oo�uBR9�B=,]V�9T��%��^�9+���c� W����gѣ���F@xs�"���)nBO�WѶY��q�g���-ͱ�V�ܲ�1X��l�$�Q�h��H�5t>\�8(;���[i^�VU�V��taIl�jݓVV�f�ʚ���Q�=�J��E�3��"� �x��r�j3���9\g�?�U��� �kJ� �8�J���-��_��Q�F�N:rk �q���[���\�)��5�����v2\H���<�]�v��%yhg��h���_�����F�)���� �q�T�%�>��E$.W�?��oM� Ho.C�QǭsN��ttB���kqA�j��[���؍\����f6oF-&�2P�b�$�w��#H_r���>��k&,�"��%��f�f�M#e���Xz��Tpƶt���˖�_�,�;��vT��ţH�L)$d�m�w_�JԢ����~e�=+�wf`I�Ջv�P�Z��O]Ϥ��J=SOK�v����ՑB]X{�����D���Z�R���=��mn���d��#�;ץJ�:<������tf�Q����x� ��W�����~7 �/�@��_�2:�q	�<C��g-���ʅ:�Ld���m�V���ux�^6��vgz�;�[��Q[��R%���Ո|�<�4� <� �z5���@4fF�g'���Wͮ��6���0(�21�y�p����p)��J��J������ b���U��ۣ*O�k��ʳ�����V���m�aC[��(N?.��q�{���TKC�m�� ���|v�G��f�p�Ȫ��9��"��d�7�jc�!Џ�U9�9�Z�̥d�ۨ�k�8�rٜ�R;�����F��2�_����M�y���m'�ydd�U5ė�\l�9#p>��?:k�J�.s���b�Z�?�ۗo�T{YCy����o�ֱ�s�@�?��������"���r9��?�o|1�i>"ij�$����)�^k �og���aY٦mI\��/�������D]�.�Xw�{U[_���i�F0f*q�n ��?:�|%��ӓ�jG���	�@��F+�K�ݝ�U��^$7M������O���Xu0`c��� g�MG�/�,ono^kh�"F�9��<���]6�*�<��zg�إ�j�zc�,V��K�y�)��ךc4Rh����C6�F@��8�y5�"A��PO�(��f8c�B�����!���l����B��N�z{�FP��;|�8Rs���}�k*��T&��٘�h3�3J����������J�ո)ǡ�Q��=����",fO���+KJ�M
�F��)#�o�7<Ǟ9=�D���:��z|FXdB�n���?�޷N:\��Z�v�����L�Xdp�=��{���𾑟�������Uy��i�Nf���/�׎G^����g�����#� 1K��&���o����� �k�uI�T�}��q��{
��i�j3��YS���s�����4x'Kv������9���(������[M�_,37L�Y�K>�#/�`8�b֬�V�3[�
:�V���r�EV9��r�Gc�"F��V�([��x�W[��h�)U�}+��4� z��p�4������fJ�MG����W'U�֣g��
�����z��b�r�����RV5���4бrqڞ���kT¤��j��>^��1�����������G�M��d���<�����WK�^�n�:3+�A=+��NGs*��V=��"����]���	{2>k�oh�LRi�Oz[��h��L֋j���ծ$;]nc��<<G8���}c��L���d[��*���H#���jUړ�.��N���� #��O�Ge��hNX"�����4��eܻ��Һ�_Ȗ�ˈVw,B����ұ����x�l_0�RrH�y�;���k���jd��W� �� �\���/�Fs޴ƒG-��t�)�l�j^m�g�k3��t2$��*�=-Ab=OqN� ���I���V/܃��SH�V���	9$���TMg2m�ӡ�OC]D�f��s�x���p��:q�הǜ��t���ι������ޓq�܄�%1>|�G���t��\�aT�0kQ��eu
�n���{�ZT���J5v����V�6�����1z���K��6�"���Ξĉs���|!�)|?�/H�S}���\�?���<��yo�Y��u�9�!\jw9�kW\榮�ICػ7{��-�C�!���ܰ��#r�#�?
�o�mp	l�nO�� C� ׮� L�/н������_�B4������h,nd��yB#��r��Q-��K��F�F�W�l~?�L��6����1V؅��zdvĉ� X3�֦��FzzR�PH?6}3S~�۸�i	�Ì��S}����ަ2��)�N���|��z�ơ[DM���l�� :Б#���rqҪ��F8�*;�"���e9��#�<�W�h��AӔv��㢼�x�w��r��j��v�
8�1� ����*lSՎ.ӎ6T�I�j��-&��4K����UWO�<�#�k�2V8�����H\H6�j�O�Z@aHL��,�8\c�ʺO��������4:�y?��� �h�fa^�V�Q� ���r:���$�}Ez�Z��0�������M��o&\q��yy�jd���s#�%�0��Pj��j���W�]xZ�T����w��s�
���X�pL����U�:i-�7}O)��� b�nL����9&�a�x��?�_�s����5P��e�w Ť�'�."ͫfѺ�s�`Ӕ����y V����e��	$�U������ �C���^��u�x���fܓ���x� ��ZM�W2����வ3_� u90T�W��O�I��p��.{�������M Y��{��(���>s��{��~���>��ˆ�;/���� Ǩ�^��i�d�f��m�~���;'f�����d���9�G�԰�,3��	�F	���Ո���Y�>�-��(9�1殺O���M+�cԥ�� ����D_��Z��Gcsfd�8 zVv�oi-�5ܢ8P�_r8�𷎀����"?V�^x?�w���V-,��3�?M՗��z�H� ���:k���$�pñpq�S����E#p랊=�{W|��N��Gaq� ٩���E�.�E�]G��=U�|���j��wq��[��1�O�B�J�VE�'?θ�-���+�܅�X[������}7������hX~�C��r$즭ꎀM �ns�ˑ�?�V[��	H�A���k-��4H�H#�>"^ѫx7�e��]�\�8� ��T�kX"������4h�-N�1#;�#�M|����|k��ڝ�_O5��|)����]���켨~�#c*G@ǹ��<C����+��-�����M���gb����(�3��۟Gsɥ�$�>~\���[:��ҮG�\��H��c��#������w��S�!UX�溈����].����Y�k�$�1�{v
�� |���_-�1��uF���[j���C#|�+~���?t�����/�J��ŵ�r��^s'�]����02���o�{_�!"�H����k�[�R�7n�����GB���FmG�I�N���� ��ƛKN��ʽ?Z܉��V{c��3)��qA�����b�̞f���@�ۀ�1��Q�f�m�l����r?�5���N�g#���r0S?�;0mw2�����tv����l�ά��k��x���4�-�"������[�<�M[A+��#�q�breCJܢ���� V�AT��_��!����'?�?�]A�Q�`
�ܙ;���*�
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��
(��?��  �<  <   �� D O G S - S O P H I E . J P G       0           ���� JFIF ,,  ��Exif  MM *           �       �       �       �       �(       1       �2       �;      
             �      	��i      �%      �                NIKON COOLPIX S3200   ,     ,   paint.net 4.0.9 2016:03:03 01:52:11 Picasa   %��      Ԃ�      ܈"       �'     P  �     0230�      �      ��     �      � 
     �      �       �        �	       �
      $�|   
  ,��      6�     0100�       �      ,�       Ѡ      F�        �       �        �        �        �      f�     w  �        �       �        �	        �
        �        �     !  n� 	              
  �   7   
2015:08:31 15:19:31 2015:08:31 15:19:31              
   $   
  R�  �Nikon    II*    '                       �       �       �       �                
                                  (   "  !  j   J  &     �  '     �  ,  �   �  -        .        0         6     �  �     �  �     �  �     �  �      @ �     �  �  �  �  �         �     �  �         �     �  �         �  
   �  �         �     �  �  
   �  �        �        �            COLOR  NORMAL AUTO         AUTO   AF-S   NORMAL  M  �  AUTO                                            @�                                                                                                                                                     0102 @�                                                                                                                                                                                                          NORMAL                d   d                                        � g                                                                                                                                                                                                              	  
                                               !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  OFF                                          VR-OFF      NORMAL                           R98      0100             d0e5549bde1a44a00f6841822859b0d86                  N          �     W          �                4          7�                 j�  �   �� C 	
	
	
#*%,+)%((.4B8.1?2((:N:?DGJKJ-7QWQHVBIJG�� C""G0(0GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG��  �," ��           	
�� �   } !1AQa"q2���#B��R��$3br�	
%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz���������������������������������������������������������������������������        	
�� �  w !1AQaq"2�B����	#3R�br�
$4�%�&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz��������������������������������������������������������������������������   ? �cfM�n�Dr<�H�^�8��c(}�yz�m�>8�e��w��݇AW�D�n��0�=V��V�f�^����h�57'1G�a�����P������X��7��̑B��T��9�զ�)oKp@˱5�E8�S
���i����#;�Fw��+:���S�)$�9���-N@�!�L���(#�X麣ܡ���#S�6�'���I��١�h��D<"1a|�t�5�\�Ee�v���X#��z\1�.�s��$�7m��&h��8�S*���Ndf ��\�z���&" ����W{� �d%��c�.�/c(�/�
�t%cU^'(�k96(�v����z�)�꫑����溽K@����GU
�� ~5�ƳWR���(NKg�k�Ppz�X�Ih�C�Of���0g�I������n�,�G��h x��$r,�+��@�X}�[�=��k;X���5�%�'}?��h�}vʹ
 =�	�i�Ȗ�E�%�P|��`c����K$h�+��OCW��f\H����O>�N(.^����:�/�0����X:�*�M���v��6ӤR1�:���D��g��" �s��[q�KO=�ۃY�y��g���fU�#9�=zT�O��cfEI�R�V���lY�4N2��n?����^�}�����t����n�c���,��eu_�(�`1�y����nkn'��� hW;�T$Ԝ�T�R��R�R~\u�Fj�۲�~ c�g5�w����c������M�@y� *�Cu)�S� KH����G�7�/��l/z���n��kV額��Xg�)�<oafiO�F�}O�/y�"�Zp#,�s����a�v�bl��(���Vt\���s�q���i��q8U'nI���DP��E_g�(�y[���� ��P}��5���ډ	�G���D��P9�%����d�X��E/���+N,�#s��~\8<sP�C���#?Jy��S:�ap��^;Tw��o"b�@v��wd�=��D�!��N���6q�i��I��$)�*8+������}1Y�Lh� :+���\��#�cҮ3�V�.��n�?��o����B@�b�
̒�
'PP�}��k}R��RH��w�l���΂����x�����7-[.Q�ۦ�$L�Ѓ ���"1�!�,� ~�oQ+$rՉ=={{W9��1��"�=f��%+	�1Я�=�Vta��M?�V*p}S5�[�mL*�.�:ĆEg�!-(?2�j%*B�麦Y�I XF��n�v[V�%��������*w�T��) ~5������b����~�n�� ���[����6�ً~�.F l��V,^.�%�L����N�
��q9���PVEr��W�'4���9>����Z���U=I�����B2�-��㧵f�j0�u�Qs(P�1�/���U%��ehY��Bs�y��������QIjY���uT[ua
�-��>����{x-����Y��O��2�l1��`�!�����V����=쒈�<��8i]��~�k�R��ٲ�����Yi�r}�+_#;�2����k����.��n�9w�����C���F�ݜc�j�o7:�%6�g����ֈ,+�y�rFh�'>��E5�����u���*Q<��,��0@+�g�Ψ�F9�'�b%Y����*�^N-�nB�8�����&�1 �L�|�L2w�*e��#q�Me�*z�Rq�C4n���K
9=Ct��n�}�!D`IW��3�XѶ)�6ࢅ����n�Gi��0��8�鞵$֓�hD�Ai�F 3���U���H���f��wǷһ)��;��m�gh��V���j�s��x����=ÐNW S����xQB���H��� �V���1��tn;���VV���89Vh�2��<t�МuV-���.�t؄��`~���3	B�7n��ϥ[_jN����8-��A�o���}�f����I>�#I"�R�<�hi��-�� �֫i�K�ݪ�i�鳻ml�큊��cE\�?�S[�H[{�pG����)�+���p;U�УVo� ���m���^�+���fv*�x�hU�t���)�,s���ֺ���d@�w�j�T*�Jq�_�bx�|(准��S5�vU�U���"�D̲��{P`m�1�WG4K*�"+:��=E$���4��Gr+G�]��>��.���,m��=�S!�o�c�v �\t����G��A�a}}�6[�Qܘ7,}��v?^�1�ܯh�K4W��)$@`rGJ�xp�FT��k?i�#����?�J����]3������ ^��&>����E����T,�[�P�g��^�v'�>幭Ὀ���5�/��2����g9�ZOur3���Z�%��Yf��~d���s���b�փ�Qܹ���6:�Z�.lV���R����vP8�횲����\�ӈmc�gg�I'w?J˺�"�TX�����nt�����iu�."��a@�����b�[�G ݁� ���V�X�D� W
w1=I�ex��V��mݸ�>�*F�� ��I3s4�̍��f��)�Ty`VD_�%��Md��O.i
&	��伍����Ƕ;�ҔSw�k���5���<�����uF���|��5yW*�@����泣�]�0��?1�� �R� 5ϙ��0��� �&��I��-K*����Hv?Z�g��0��)�	�;�0�4��@��?�V[�I�`s��4��#JR�>�=�) ӧ�&��M ��p�T~��@?�#2�I���A`7R���\�.O`�?�D,.�������v��=GnI���2�Ė��J`D�:1VR��]�t廻�Y��#�x��5����O�!�GB�Զ��ų�	X�vCZSj2M�5udzJ�@ & ��J���9�wJ�3/RA̋ʓ��Z�k��.#��@O��w�d���i��6c�iBq�Yw^$�m���#� u4�_�Lp�y9�\�ҧڭ�?f���Ի}��Ԭ���#���ż�?��Ǫ�E�[ȇ�*�"�Z$`����Kg��I՝z��⢑�"b������~�0}�N�guR�P��1$f�i<a?�J�W$��`�9ȵ�i��Ge&��5D��?�>4`A\�2}D��:�@^6�7�	#뎵�ڬ���s�!���fK��D���fyU��8����h��JڤK�Gp}Es��u6��G2��~~cI@��F2*X�����k/?�F�{�Y'��q
����洠�P�K{���ȳ��>���-����.��1W�ɞ�����5Z+��Y���?�k�{�C�y��|��O�����W�*O�JFvgS��4�+���9R:�Vm��i�%% ��pzW5��.ĳ�[�?�0]H�ha��CI��]E�ѐ�{�"��/ &!��.8ˑ�_ír1_�ŏ.R�`b�^j���f�(IB?*08�ȡ�Z!Ԯb{��������Jf�2��i7T�N��Vv�+8�s��-�m��<�S�!���}�����09$��Z��<��n�g���p#?ϊ�${:S)�����;�L�Z;{��qE�!$���c�M��NԹ4�(�s@	�	��J��4��H��)��"���x���<���v����"��n�=�Z�N��M��UGBH��#Mȇ5�	�]�[bA��k��{�P����|���c���:�҅�)�X��v�.$by#֓��ƪ��F4���&8JH�;܀k��7(���eo�]���fڅ���iѺ����*J�SՏ���1l�2��^0<���?��,@�3���r�Jv� }У?\ԩ(�b�>��ԡ��q�rX�--��d��S6q�	>��j���UT./N�<[TH��]���#Q^�3�=/sUfrp#����!Qy�ԟ-񨌠��?�m̖��é�(|��9�y�ݟ�O�2y�Rw
�E��F�\T�=H͞�	��C�j瘽��m��d#<'=�cv��o ��5�4
�mP����x���I�4*�hd u;ME���������qT O��J���.H�;��sM��,�V]�v��S���H���̂�a�1V�(#q-�I��z '��֊i�(b���j���52��I�Q�4�U��摃�  ?��协E9������/��;�"�#$��O$��zG<��£���N�a�/S��b�.q�~�汗��s�|�X���y�@����ϜuQ��F,��oӭ6K	�6��T����X�l��G�O]*c�h�kv�MDnw)�jӵ����3���]���s7�Y���,��+)f8�o��/�Yc�U�G2cO�µ</g�ߝ�P������]�u1�Rwv��lI�;�j\�ه.�)K��A�ck������|���oi�+�%��m��������*!���#^ �Evg�u�5��-Z��$��s-7���8�#g��[�r�W%��e�����k>Oڬ�#f`��,�$��c�wJ��jLɐ���MSJ�	^ڗ-4;H�!���+Mb�  ��s,JHV<g��&�4!�$���.nPv�h�q�w�����M�� ����?Z�}Q�q!�8*�j�ޱ$����pQ�Z\�F����b:d�R��&@�!﷊�ִ���6��� 8�]�r�,��=?
C7�2�u#�+�]i<��˱ 8�f��D�Cs�3�(����`���.b��#��YwIx��������ڞ�SN}F�� �dJw�k-�[)�dS�\-J�Au��dS��\���� �7k���H��t��e ��A�s�vEt*���]4�EY�@a� ts��ù|~UTJ>R�֜����U#܇NG���7�� �q��B�d���ǮjӋ"������j7���kCZ6J��dɤ�A�r=�/�8�$���Po����Ν%@''J{F�br���[���P�����J�s�.���uN���l�+ ?µ��=V���x�h�@���^I��$|� ��˼�i�����@@i� }��R�[ټ@�	��kR�n���2��3[�,�H L�4�I�w1�6b[�V���Ow��D����]!֛���["$����D�%�Q��2m4->>%V���j��A����^:���]d#��R���9����|����K��Fv�$����M�u�F`�:��[���?Q�֛[�%��	��+���ڪ�ybTF�Wq����g�RM���GK�Mmt+z���(��y����洛��O�����]?������a,#���u�q\�<Vhϵ��
��k�:�6^ԝcG��j��RO{��d�:h'�u+�07�5-����.mJn09���Vyw,�Y�!e�T����L���$�	��pރ�������g;_w��9�둟�`K#��r���4�S%��WҬ��6�ef?4�
�y���zW�R���ȧ�i�qϧJ�^��!����s��ܓ��U g�M��
��ՠU�w�#vz��'8&���i������[L���{�q�ʷ�q�,�����q\
��3[���I5��r7�=�B:���ۉ��9l }MC���!Tz�<��93���e�P�85Zaph�xy���D�?�>��tX
/u�.v饇l0��o5�!ś��	������})@
1�N�4�{R��0$*De�Nyb�I�1�j̡ہ��7h�K@J=���P8�'� ~�=)pq�Q� @;R�ӑ@ǂ�Kژ�@��V��ff��a���=MfYR0yf���H��}je�ћ���۳��^G�C�^��c�ݿƳ�Ave%e'�r6�>���\��xU�t��`d�:�)]�р�dYf�0Fj̄=*T��mB���	#�d�&Bݭ�!d��j��q�5�k��yr���j���S��&+[�?0<��J�O�c�
��,�G
(��jo�r�'��Iu��$W5vp����U�b�лk�W'�jT�\�X+?�#ݵ���l�b1]�%���$Q�j��1�G(ы��L��$�f�2Y��:�;{�����uǮu��p;�o������gc���;���n �}1Yݖ��K���C(݇0�#��z��dyN6q�b���,�[�`�ϧ� ��[��h��\��i�F�'��c>����!�n��x�S��Pˡٿ&���4ԇc��GNh �nk�oZ7���4��?o�mV�h��4�]Dr��{L[�+Ÿ��N
�q���tdG)�vj� �(�B��Sp�N$ٔ-���\E�g�|�u��C���v���D{��U�D�تs�A(��U���`}X�k	HQ�e��0ǹ�U ����V!�&��}�6H�9
�G�`Ӥ�� U���@�Rn�)�{�����#Y՛͕1��*oҌP��7��� Pw��n��S�9U{��.ebl��MiY�(�&�ˋ銬�P@lw� �V�_[���1߰n\q�=�����J��ѵ�{`n�,A�t^$�ۻ`�.����j$��[�V�-��z�j����]I.m.� l�?�5�EZ��M~��̄|�'���5/���koo�X�^��j��y��ב��F��8@���u	�Mv�_��F�*�nǸK.�I4�&V$��5����m�hX28{SQ�aA�Ee{3E�:\H�:�⹟:���G\c�� �oi�������¹OL��'�� �z�J����=����9�$v�U�U���U�����DA<ύ@���N�r��ʽ+{Hb�0=`����m>�ds+�RG$�[2��h��*6��q�֑uW!R�}7���c�dVE�����5c��Fy��h��{�}�\ՐzB>�Xc��\�>Y�h���!�x�����8�)����@���8���{�B�=(-���6��aT'���8�Q���v���ƕ�8Z�ܰ�1�����F�Dە�ޤ,@�
�����-�M��;@���3́J�q�O\���u^Y�xU4�y#��K0=�ŁWi�4���,�(�5��T;�;S�j,��zSՏ�T22�Mf]k����� y�¥���W<⣓�|oP� ���X�|Z���iDI�S��%�Y@d��ʯS�ҡ�|�� ���� 0�Y�z�qz��y}}%ǟ���P��yuFK�������(��Z��m���$w�I��x�=��t淺�2���r6�>��X�Gq��`���G��d@?��sVQ�`w�P��H�a-rz�!�].��͚�=�G#<�����@vm ��[�<���1�����t3g�^\!�R3�������7��l^�O�I��k�W/��4���s�H�s����o�qUqc̌@S�^�Y2
3Fxc�"����cM�m�T���TI<d:'�t�k_�z�BQcf�(�����g:���:��_o{�ܚt��&�8��*cd�.xr+�|3��C�����q#� ��~b�k_��k�>�-�S��!��P+�5���I�M���*�uH��ԇY�� d��b��B�}>�[K�$g ���U�W���!I����0a�i�>3�qk#!ʱS�j復4d	Ⱦ皇I�)L�M�s�Ja�l������+(k����m�Lܒˁ���Y���tII;cU@����X���8��S�M3K��v +�����Ev�X�����5F�\,�A�rI�کE+�e>n�|��������������	���ե�WI�'��Ep��_1�m$�,��֦�l-���M�u'������hb'ڢ�E�EV`w��z#��D��u�J�]@~@�Z�_��[#��5)P p=��<��Dܪ��<���Aqs��8��۠�Ya��x��(P0�}鈩k�i7*{6j�`,m�3�E5�@� ��'��2M�ک�x�ؚ@h�QLi��Ybi��h��T��Uv8=�&�3I� ����f��G��,���y�6�JТ��,s�~���jf�
12C�m�!X����a{�5�F����gB}O��U�M�I`��B�8��֨�ܲ�-�EI����T�����L�^:ǀ�p1҅;���L�Z�#*��	��������V��� ��hd(I�����W�G;<��q�ES�i.�����!L��9�5��|3u$��}�q�b�����1$/���Y_֡Ĵ_�顁a�I�t����qT9)�=(�e�u+��>�#(�+��5�f�%��OZ�9�q�4�H��_���^~��0܂2G�%���կ$�nԹ�v��u�"H�V�A�~�n�p� Gp��j[���;3"�K��[K�k�B���X�ֺ�s^��d%��
X?�Z�eE;{�TM}
�!��\Qv�������&e7~T�F��CҬ�fh��­h�y@UQ���Mh��2�	 8�Z�̗++������j�֛5��r��[)��o/pݵ}M �-�Ќ���� J�Y�VG6у֪�j�r�5܈mn>Ȥ��I�ٸ���h�'��8E�l�����1�T�#��uh��ĒF'�dI�W,��� �� 
\�B|�b������z75i5[�����%�p[Y�����z�~�4�F5�['kq�@q�ɬ�T���1�����$\�Q���}b9\#D��Ӛ�m/ �x�Rg\�l����4{ۧ�c���N�{7�2�R�s�\��iv�?o�LI%�u��c����Z����*aۥIW4K�������-,)�CrOZ	=������Ie��E����]�N�y�S̆O:	�H�*��~Ls��;�9X�N=�*�ß�q�S@W���"���j�������ûw���)�ߍ#[�6��7P�Ў[R�oY� �,�q�� _֨ip�Iz�Ѽ���{��]���1!�ڼm	�������"K)9�p3��9
��o��)�K�r[5Il�q~\g>���2�[w����sRXB�F98^��hi3�b�-��bU%~~�u�G""K��8��O�)��S�m94�5;�� }�S�c��i2�EqĬ[��}�j�mٚ5i"h���i#M�#��FO�6�4�.	Q�ڗi��!�F6��nyl��w+�I4�B=��hɦeG����c�B}+>K�g*p��%O�TL��%A4��Q�Y-��������E٢V��U��5u�H���n����I�DR4`�W��֞�V���V����6�d.;U6p$J��m��y���ZW;�,�c=�j��!�0"��OU��R�[Tf�O7���:e�$w���Nv�a3�;��/�W����}i�\Ik�	0���ZEX謹��H80G+G�GE��(��F�v
�ok5�s#�$`��ң7�\��9��U����p�u�s�*H�;XF{t8�;��V&U;
rq��󬋹"4o��/�s��j�-dW�C%�`��=�O�U��2��+� ���Þ��>E�Y�6p[�_��N��R�2��rX�q�ZЖT�[]�-���������c5�N�4|"���=r?��G<e�m6��$i nI?��ap#6���
���O��6�Ў���Gd��Wd3E� �q��j[\A5����:G����U�dJ��'��$Fs��÷AT%�O��r1y����Г4Ӗp�S�yf?��V��� � 1�O��X��&���n�N�ݥ���H�C�~N:���)4�c�s.Tڎd\���ϽS-��t��ceH�8�;�袅�X��fL㏼@���Q�����p~n;�8�ԩ R3�8�0V�o�N���:��c�\i���<���Fi#�����o���9'�5���eբ�3 <g������h�c�΅d �����U����KmD�ĐL�&~�'����j)�������At�����>��\ �
��c$�D�8犸4�{�d�4(=�7$R��4.x�ҍ�� Γ�8�	yϵ�?�C���!?�@�01�S<њ�w�5�z�2F��G��4�v8���I�'�����f�����G��p��ђ��ʺW���հ
���R��Gm	����^bA�1�'�_�*Sw3��Ƈ��7U*�aYr��20*��rj����}�G�
n�}*��t�V=i�V�+�A:F��wdU)C��x��-/�Y#V�>՗u�J��=A�R�43,o�P[�C���u��D��
:ڲ�<;!�<� ��6��Zr�r~���"��"Ri�Ԡ���X\n� u�.-%2I��m,8_����c���eQ����W=�ڦ�b�U������s��v5��\��ec�KK�Kt qߧj�-Y|���ai�mŁ(�OΪ�6>Q՗`l�#'�OCN�^M����`�T�(~d��j�h/#��g�N�`F�Gl~���4�X��8����:T��v�)+|�����O�52���փKC>k��X��wn�O_�!˪��e��򫷺(2�n���W��SLG�v�(�z���v�z��ղ��ɐU���L�բݶ9��v�˃�5�]9h�|�J��Njޝ�����v�d�*�=��u����m�!�Q\��>�q��ۚ��sN�I1 ��ݿN�B�P�I�3l<�8<��|�ѥ�($?7˒=�+>V�EX��[����A�՘rX�}��ڃCc�WYP�&�����J��o5�8;���zs�?�zm���W�C�xeE|	1���i�]�&��+eVy����#��T���!H�)+���@�yq�}v��j[��S<ѱu��<��j��B�7S!,e|���ℬ�̣{0�a*���1�h���gd���z�}+.k[���m�R;�U� ��Z��c�-�)��1����n�2�u�ǃ���t��~�ʞn����t9��W;i��x\�� �H Զ�ť�a%
ލ޸�G��[2i�Z,�n�wV�	<�\f��_[ȱ��|�^2OһhI�W
���=r	^euX�,���T�G�$�r1�zf�(�̣�i=qJ�UBι7֛��T�2:�o*y�y�G�㊛��N�9�d\[.Gz���GP�2H#�tls�g��ڷ/����w�1�}��H���6W0��m�@b�v��V4���������o�/�y(��F ɣ���-��9��ø!Q@�������i��p��y��D @�J�{S�8 .��X�ݑp�j�0�j]6���dw�ȶ����V����$(�i�l��4,^�� ����s�h������#�s�z��bA�vBYO �ps[2�Ms�]Pͼ1�l���ǭY�ң�E���q�{Vr�6`�CVk�{CaI9�j��e���#9�1�Mwk{�X��׵1�0g�J>f����.r�G����*y]�m��A��S�W�#O48�ɂ��U��<���	b��v�w5�V(�Z�L�e�� �W9=� ��!��2V7 d����*���k���,$-S��G9�X�֓\��YŴ+��u�I6s�c���E�����Z(��B�?�����ֽ�ݸ� �� ��E)l#)?ֿ���o��J(��\�� Q'����������?�P>��� �?V�n��>$��EL6)�/V��EBu��)�4���
�� �d�b��;�I� {��EL�-�����G7�� �
(���i��������(�DW_v�`��𢊸��8~�{QEhOQ{Qފ*J7�}i�֊)�b^�� 1���~�QX�٫ؓ�RI��E�"���t� f�������lČ�� ����d����TQM��   i  8   �� P L A Y - B T N . P N G         0           �PNG

   IHDR         �w=�   gAMA  ���a   	pHYs  
  
��e   tEXtSoftware Paint.NET v3.10r�%�  �IDATHK�VkSSW%v�	����?П��i;�3�Ѣ_�����Sl�ZE;��AȋE�*���B�%<J��n���7&E�43{ro�k���:�D�����ݵ���&�F�fժ�X�z���b�XX�p��U���V�y���eTl�q�3���n
�
�]�;#8�BN�2��� sKo�	�o�n��mx���0.�P�)c�8� ��[
v�=����u+�0aǖ���a���,�Y��(�y��`c�i�r�|B�h�;���x��?Y�Q��#(�FY�#��ދ���*�p���	�XB �o��0��A�p�~y_���,�L��]0�V`aȷ�d6�8��W>��Q��\S�� I¬҇�DժK�q�EAY����lŌ/{�0M�8�E�N�wH�F5�Wg2�ѫ�	��Y�H����y�P\3. �v?zNӑ�OG�8n��T��ڡ��nJ�iA���v�z��{��Ƞ�J�F`鏢�9.�H!�Vu�}*I �Ff`�:�K�!T�/D
*ba�n(8�.���.�R����]����阠�4&W���w�{Bh��,!��s���Ïs���.�iقFǯ)�i��)�:��^��HZ�$���kz�����;����=C}�0��^X؅t���P�,���8���nP����%$y�u�=��W$X;&���7JI �2+�ؘ�
$	���H'���I�#�2�U�H�H$:N��D�sp-%���D�Y\O`j�I��̊Dd�ν�	�q0���_]D�X��C~�Ϡ��H|�,J�w�vO/�A[�!;Ħ;�>��e�C���R�'>��D{�R-,,�V�L���d-$l*է�}�FLbk�`�W���,�y����]�U�Ek���IE������Y\�,sqU�t�R�_�"N��m��uޏ�J�-��
5����"0]����:#)@��2�(W���S	�J������7f7Lh������R�U�y�\E�!�r�Տ�J�D>�\d�����X���w�OSs��f���݅ �5�ԙH7�!��k���}Y6������܃nD��l#I8�8�|)����*?~�	`?�K졔�����	.���:�>�\c�u�갖�<�t�oZ�d~�w����=���A�-7(N��3,�j�j�:�ԃ�'�A��kd��Z���䟂�.�jٸ8�Y�܆oO�[-��a���?����p�g    IEND�B`�   �  D   �� P L A Y - B T N - H O V E R . P N G         0           �PNG

   IHDR         �w=�   gAMA  ���a   	pHYs  
  
��e   tEXtSoftware Paint.NET v3.10r�%�  {IDATHK�V[S[e%u���m��'���3�>���l�3ކ)��GJ/T)�P�P(��!���D���)�V�#�ICH�r����)�ٓ��Z{���w0乶U����L��L�6�����[�=�J$��2`���N��·���_d4�]*;;��@�o@�]���&p���΁9�60��	�/����u�ùۀ�0��>�S���<Tv-����o��K���뇁K�������u�r���%b2L�dy���'���4�?���L�)�$`�p�C�0~`a$I����H�o��#>������I�-���I��$N�>�$�c�p��N{��IL�W�H����s�p�j��'�`�[q;��J27��ٽ�s�~������	��y� P����F%M���4� \�t~��7�;��z-	e�Hp%�1�������U�~ع4F�"�a�Y�d5���_ҲH
U:�����W���b��BT�9��3p�]��Q�|Ty��Ɲ����2���X�|����7L�����J��O�좓#�rh�T� ��`�>�����"�Ԣ���_&���Q�'\�1�ص�]��V��H�*{bOpz��>h%A	$�Z�q��-�x�r��	�MI,ʝ@a�/�F ��K �od��(���a<�D�����4�2�K�O�H���"������Ğ�Ɏ��$NҘf��7���h�$y�D���X�d%�Ns��/��d����/NMk��m�@Zj�4烌���)��M�~}�J��SU_b�$&��D����%�~��{f���~�E��ٗ�F}�D�g���C��l���Z��67|���� J%�ծ6��n�;�#pT� �[�{��[J`�	�������j�|�%��9^L�Y��Cr����9���E�$�4�,���e�X���������'�[;kǖͫ��n�<�C��M���ױp��'i`F�UgP0N�7r�x�`I���Sk?*����<�2j�o(�1)������\/���V{�r�7���Ar�K�WX��������E�#7�.�L��LU��=�q|�8N�#�62��xv��SОpa:tpѼ����zn�o>���|>� 2�>����    IEND�B`�   :  @   �� P R O M P T - A R R O W . P N G         0           �PNG

   IHDR       2   =d�d   gAMA  ���a   	pHYs  �  ����|   tEXtSoftware Paint.NET v3.10r�%�  �IDATXG���K[W��:��{1h_l0����`{���-H���6i�d�L� uK+��\c�BV��2���v붂5�F�DS�h4�Ѫ��@�]5g�ss��f7ɵ�T8h�z���~��9��5I�W����c-Ү���KJH�K���_>��|����u���o	I*����?�x}�G��Y��$���`Q�ݔ�0�����6��4q��R��߬��_�0E�lB�Q �0�dw�����gl��V0K�i!�,�� �t�b�7�|b K *���vp%�
�
@?u�J�d -+D>pr�@6+Q[T �	)�R����[�o���(p�Y!�8P� P���\B���X���IR�P�fN �� *�tV� ��v㪀V뭴`�вB����KV�S 4TP7(Zme4�b�`�����U��F��@fk� \�+RTn�*!�����Ť�x\�2� �B D�i����@��$<�c^0`
 1���A	�G�0P0^�T@KUiҼ���U6a<@-{ѐ1h�&'#��@@���nY!��z�-�8�e!��,���䯮���r��Ma�VA�
u�RY1K�?���*Ц͘�bz���<�e��b�*�����r ���W�����'W�
��[!N�ts�2µI4^d��҄! <�I _Uv�@���:10U�n�:��/ۥ��p�`YUZ�*��BO��C����{E�J3krU6IQ�}ӡ�5�w��AX�G�JX��۴��'N6�����~���'怨�	r�-+x.dˇV����H�|���K�䪬ݼ `7���3�V�	�QV�tKr�h�a��6we��S�{˵��C��~�V�Z�B����=8����`7��g دy'D3��l/KQ��LmPbn#8�����N^H�{*��^� �V�mˊLU1�����W����mkw���x#���H��n�
VBѠ� �a���߬��5�u�}ӊLR��.��\�G�,�Ntz���
��%�"H�b�U��.H�m�����(���,}* ��'�j;mڋ���~�����~��w�~WhXiP�HmP�O<@L�|��8}奂+V��`��${��Х�~��yB%A��Ԟ���Q��S�N�
����}_����؎�+*�*neM���|�|͘�'�y��2o� 
�����i�4�zk���հH�����\�*�HAenP����B��5kb�ЧVC�+*���!B}��A�f/���P�F�� �� 
D�����]����/�7.:���
�����:d��̎��,<\�W(p|�9o4 >�9��e��X<v|)(���x�{ߤ��~�a������,<p�Rx�0���  xg2P0DQ�b��F
�~5ѕ(|n�Z�z�W ��+΃)V|�V]����ZG���au�    IEND�B`�  'f  @   �� S C R E E N - B O T T O M . P N G       0           �PNG

   IHDR  �     h�u<   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  e�IDATx^�}�]U�5=��J衇�%�	�4頢��>��!�(�DJ�(��
y�|����� E��OODz	�����y3��v;e�{����/��{������c�9�Z/T�ߚ��rʕ��v���]w���,�w�
���9�}|��C�<������
�&�[��I��%��!�����_vh���^o���~�u�w��|֬YM�2e�E]t��v�_��$�[|�����_o��^{����W_ͺ�^y啬��_�z�^z饬W��_�z�fΜ������Y���Ϛj�=�\�t{��g�~i�<�L���駟�s{ꩧ2�1x��'3�}���.x��S���{�$�ST��y�^?��+��yzI�<W/���j��yΦ���m�����B���~'���, ��%�.�����e^xaW�� ��i#F����
+L_c�5������7�|��;���������w���k��vHE�"�������@��?�C���0����
 G������"�L_f�e����*��^{��o������z�.��2}����~�AM=�#6+��I�s���g �ğ���-��"�g;��S�����٭���3���nZ��$~E��K��_��?R�D����0�D�p��C��g �ğ��3��@��?�g �gN8�5���N�,��`�}�ݗ1�ߋ��dC����Y/�O/���Ǭ���{��z��瞬�v��wgM���+SKc��?�!,��;�̆b��;���~��dGy���%�?W_�"��`yĿ�{d[m�UKUl��6jm`@Մ��@�>0nܸLM�>@����b�-V6�'�?s��'����EĿ�n�e��o��;�	���������	�M7ݴ
�g �B�_/�\D���Ov��	��������~��-��Rer���I�����cV?�F�j�@}@}@}@}@}��>��kV!����D�c_�JPM�����4���ϫ�?��Y�ov�g����sEď������Մ����������@��rE�����"�����w�]M������A`�}E���'�G�����P]�	��������#G�L.����z������'��	��������\aׯ��B|[������������_��h�"��������+��b�݈���c���Z��0PPPPP�>P���1�_��o��f��0PPPPP�>P��Ĉ�2�?v��LM������O5jT���+�ߝ� �����e���6�6�pC5a�>�>�>�>�>�'}�"��6�߮��zٺ뮫&�������,���U"�W��7,C�묳N�JP�������*��F�\�7+���� �Xc5a�>�>�>�>�>�'}��T���ɈD�_}�ճ�V[MM������IXn���o��}oE����j��J+�	������>��.�l��<��=#~V��_��[+�w5a�>�>�>�>�>�}���T��o��W⧥�&�������T$�+<�__���Zj�LM������G�H��z�?���i�/��j�@}@}@}@}@}����/�U$��<��RD���/��"j�@}@}@}@}@}�O�@���3�\��2�e�'�#F�
�����2,��o���
��޾.�0&�������+��=���w���o���hK����������@�>P��/��IEĿ�v۵�:�I�n�pn���������'��A���Ƌ3�B���;����.�y�\���,�䒷�37�	����+�����f�m��w�9�~��3���}������QG�r�!ل	�M7�4�m��Z�3f�C���su/t/"}�v��
��1ҷ�&�{����~�A�c��q���7! �Aଳ�z綾^�]{����ɓ�M6�$�r�-�)S�d�g��fΜ�͘1#�6mZ6q��l�ԩ٤I��s�=���\��*�@I�?O��@�����	�����	�����	!�CD�=[��G`O����?������孃\�X��?}ca���b�-�n���cǏ?v�}�e�`������-"��⭳	�X�?U�c�d�Xl�<v�7;nܸ�H��k���x���4p]:�M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@C��^�B@!�"�&P�9��B@4����!�uZ! ��M  �ou�S! �@�a�F���<���Ǐ�3�Ȯ��l����&�l�m��ٔ)S�ٳgg3g��f̘�M�6-�8qb6u����/������s�9�3�<��N8a�^�N%��B@�A`�ر��~��o�}��g��]�����wg�}�{������q�����}��'�{ｳ��;/���~�"|���~���駟�����W\�]w�u�7ܐ�t�Mٍ7�HA��׾������X�Z�! ��B��������t�M�m��&�i���=��#3����7��?��e��r
#�i��S��Tv�����.��E�W^yev��Wg�_�|��曳[n�������NZ��_E�B@! �Xi���\e�U�ѣGg������:�y� �C9$;��#[�?�;;��[��g���{�م^� �_u�U�ɟ�?��}�s�?�A���! ��!0jԨA�٪���!���Zk�l�6�6�l����\��������:�E��� ��V��tN;���c�Xv�'����>�%�����:�B@!��r˝��
+d+��r��j�ek��F���Yg�l����6�pÖ@!��>��m�ݶ%���n-w`�=�l�(8��젃j	�C=4;���[��1����"~u;! ��M!@�_~��W\1����w��e���ǌ������FmԪ��|�ͳ��ڪE��m�]��;f��K����+��^{�����k��=��X#@�?�#Zn�~S7[�B@!��2˜��`�g��'�����ٺ�۲�7�x��[l�E��Y�Y ���]w�0�/�0aB��Y�����gx`v��g�8������	! ��h��WAT�MX�sG��y˟��5�\3j���Ǎײ�1�˟��)9���M|W�S! ���E Ex�N=�ԋ?򑏼�| ;��c[����}�?��}�?��}�?��Y��YG���(\d�� }q! ���@ ��,�<�LV�ʞEw�����Y�>�Z�>�Z�>��-��$~�e\ S���?��^|o�C! ���B ��$�G?��gB�g�U�,�c>�,��-��-��7������g�? W � �oX�}Y! ���@ ��8l��A����B;#|F���sZ��-��-�?6��,��?��cS�( 8ݏy������E�~�G7p�1��B@i�?_��#|N�3��T;O���g���-��ҙU��S���M�3�?6ŏ��������� X�' ;��/'��B������3mt�Ӎ�i�{�g.���p��Yr�%3L�kY��?o��S���M����7/ X�g ��[
� �������E�B@!0� ����{��v�'|��'�Ӻ��O�_b�%���Z�e��S�lU?�7oU�p��ú �0���� `q!S  \�K�B ̃ �6��C��	! ���� l�A������E���=�3�	�}��9}o���[l�lĈ-����1�?��-�p�ɞ+R,P p@/ 8�)  ����?��9 _� S#}F! ���G ��+��F��ɍ�i�{§��	�K�z�g?��d�,�HK �������?��	=����sz �� ��L�� `!`� �����Ơ���B@! �  ����#>����&��O�>mvO�\��dN;��k8��$~�E]�e��|X�ZՏ��U�@��J�f@& X$h  S^ p S t �ß� � �pW,���#��B`�! ��v�-,|K>�rO�$`O���=�#�������^�e��|������U���_`����?��� ��� S & ��9  ��� W䊃 �@ \0j��P]�B@���7 ��k����E���=��6��O[�>	�����8ߪh'����i��|�������m��F>������� <�	 .� w�c
� W�`�+B ���z�B@�A� -�u ��$|��F���=����O��>����*"�5(�ň�����6��,F|l���G�&��bw�_����u�Yg@��  
 �0�# ��
�gB ,9(o�.Z! � �w����)mF���=�����(�>I��\��SA��E]��N����m��Y�<vj#����|���G�5@ �p ES t ( �V �E���y������=��w���r���A��B@!0( ���2�_K>�nO���=��.���(}�; �M
@8>F���)~E����YD��g���s,���q��L �Q�������@�%�M p�!�X��# '@ ,:(:�.R! �>��G��/�d����E���=�����ϼ�'|���A�?i����H���� �S�j��7����7(q-C ��y0z���  ��� �^L� W2� 8 *:J\��"��B�=@�K�����<	�6�>�kO���=�����O{��m �۸�e�ٽ�.@t7���	-�Ԫ~�-�AO!Ꞔ��a���Q�Zp�E?�s��S t ( �p] \�)  ܃� �&`
� �{��a���G��B@�C �?��q����f�O��>mlO���=�������@��]U�Sg�u�{/����.�>�O�H��pJ��ɓ����*��ꫳK/�����������/��=�ܯv�:�� 8�	
 � � ���{x��	�� ��N ���F���B@t�b��OB��o)§]�	�v�'|�y§¿�@7���OR���k[Do$;eʔl����̙3�3fdӦM�&N��M�:5�4iR'�߾�R�Zx6��& XXh  g0@��{0@��K� ��E\ 	��! v�v:�B@S�W^��a#|���Ӗ��O��>mmO����A�a��ky�>"~�=�A |3^���ҍ0��� �^y�+!B l;L����B@t
�! �H�����i?{§=�	���'|�ێ�g�����E:u����!�ۥ� p)���5`
�  S^ p�@s ( ���9 �ۀ) s   n�
���U�B@�!� �8�,E���=�Ӧ��O�>l��@���X���c�7V� ��& ����
��@���0���� ��`.�� ef!��V�<B@!Џ�.���=�3�l>�fO���=�Ӯ��O;���t|���΃���5�"!�, \R� 
 .(� �4��K � �J�\1�:��z���'��}� G�O��i��V��O��>miO����y�'��9��������  ����z��
�0����� �^L���7��"@�i���7�T! �� +�H�����i{§��	���'|�ӎ�_�}�Y\��]��҇��o�m��B ���L�� �:^ p�� L p ��)��5��
�����B`h  �¿S���6�'|�̞�iC{M�:��@h�~AiB�\�5�! Z�q/ ��S t ( ��� ��  �L /A \���O! �2�{�E���#|�-§]�	�v�'|�͞�iG����_�V�7�;�� ;c	�ۼ ��� P p�/ �'S t ( ���	 .V���� �g������z��B�M@��A�W��g��i�����O��>meO���6
.m�6/�k*������~� P p�� L p/s ( �WB� x�+1B ����k7^B@W@���� �A�����'|�Þ�i{§��.��o��סF�N ��n
 �q��	 �� �H`
� �P0�{+00� <
pWh�����B@� �(�Ř��J��i{§M�	�6�'|�� �i8���J��/̕! �d�{x����@��� ��
LP pυ�0�1 ]_`i��#]�B�o�]�,���g�3�k>�^O���=��.��O;y���Ko׷_<qaC���[��9{���{"0@��{&x�=��@�%�M p�F��p�`��^! ���@ ��$"�>�[#|ں��i�z§-�	���#�_��l��
�0!~�=�A |�1��  
 �� �R0��{-��?p%���t�B@�!� q�) ��i��Ӿ��O{��υw8���=�������>��aF�v�F@ �� �H��{(�`_��
�L� �� po� �_C �1����_!0( �/
�?S��'E��q��9��X�S�8�[�7I��61�>�����ES�7$��ʉ /� ��	��)�X���?� ��H��� �R�LP pφ�S��J��B@�5(�Zy�����b�ϼ�E��k=�s�g^�<��s��V�Gk�k�3�c�K�� ��/ߵ-r� v��A�<�gq�_�j�$wZ���ś��� �n�{20@  \�+>B l��}�9����A �{I��_��i�z�'�{�g���.�@e��[����9���qN�t�!U�-��ǣa8$~����2fi��#�HAhi �
 ��`�{8� 0�+@b%ȍ��C�/)��� ��A����j�O��>�YO��ތ�i������6��F����8{� `!��p�z�zq��N��{a$�k�R>s,�g=�|���i	AZ�t� �^ p:  �ہ) �9 _� X��U�B@I@��bJ��)§�	��'|Fp$|Z����`����5�}Z����>�1��1�0p
�U;�Ù���H�ɼ(��ǾA�{/x���� ��� P p�g \`�W  ��}G�/���țn���>mU��i�z�g>�>��<᳢��:
�^��>�Ĳhۣ��#>�}~�O����1�=��ٗ����#�C�m�(����3/�ԏ���!�^�j@�r;e ,5��{60`�{:0 \)�+FB z���.��	! ��f �[I��O��i�z§��	���'|Vn;�Q��8�
�,�;	�Y�s�蟃<�Ƚ �]�N����ڿ��gD��q//���n0�E�t�� `:�)  t�� �^& �S t   ^�
�\Ir0�]�B�+��7 ���tn��i�z§��	���'|��� �O��Zp���6� ����h��?Id2��T��j]�K.��}ڣ�s�f,���V���v �M �/0@�������) :  ��) 
 �1  fB �@�I������ȇ^m��|�E��Q=�3��Ob���h�?��U :�"�[���1���<Ƀ=�MR������Ql8(6r��!�>����D�O�_�O쎪�_x��^ po� � ����� .m�+J�x`"���EoB@^��|�J��$|ڢF��K=��N��O��>��
T�k��'��$ZU߬�f�Ǻ����5���G$��6�Փ�U�C4��B�7(��GQ>�::�� |�;8+�) �
 ��`  ׃��{B�
 �4�'! o��Q! �@# �_	��5ڟF��E=��6��O[�>mWG��`�~�|�~��q�/��1�AF����lx͈�o� �z���CE�G����cQ>���3���m;�� �Q p// � ��	 �i  ��`
��{H0@ }��@ɕ(;x�:�B�Y@�#A�����R��i�z§}�	���'|گ ��7��o���#.�B���<�	��/�{���}�%�G�����H�Q��g'�uc1&� ]�H�L p-s ( 8-� �a
� ��0��%�_  �� R+Gv��ԡ���G@�K#�y�y#|�;-§�	�6�'|ڨ��i����}{���18�& ��?zF�\��:��$� "�=��^�G?Z��ψ�_-��>���z1�nQ��a�� t��0��S �7� \j�  W�D���~�C�! �@!�[� ���)>mM#|Fk��i�z§]�	�v�#|�M(���a9�h�( ,�窀��8��{0�C��͈����eT;�`'~D�{ ����S+sr���ݪ�ӑw/�1�'(��@��� E� �/L� W�䊕�BD!�-@����O�����>��>#dO�$NO���=�d��5Э�x�M������p`g��k �{8�s�g,Q��}�`%~D��!�&n
�|����MDkz��R gẞ� �J�^ p�� � ��p/	� � P p�	 ܃� �۹�eG;�&��h�" �c`S>�"|ڛ��iz§=�	��)�A\ۡh���<�ŕ�Xk�Z0�����2��蟹�w��q��6���.�(�4D�/�����K�-��V��4��& �d�9  �C� �1� ���@��)�� �@'�v)}N�� a��! ��𙯴�6�'|ڜ��i�z§M:@�3��h�(���-[��[ �v 2���t�?�o[
��ɓ�9�`"~D�;����|N������Sep�{V� ��A�� W��@4���� ��1��X� ��� �@ lV��6! �@� ��¿��O[��Q�'|ڙ��iwz§��o���5m�Vj#|`�E��y)h��ҵ���k���O|�#�������WB�-�|n����Ck4}R�^�
0�N	eߠ@��!^ p�(��	 �a
 " �r�K�*^��.���� �k<�״��iKz§m�	���'|ڞ��a�>���鸚�b�o^��û�J��Ks`g���9����<���RGl�M�L���ԧ�k�!���JD���9�M8���� _� �E�Ԑ t���@�t� �1�=,��0�:����ӹ�����w�����Ӟ�O��>�MO��?A�σ�?	ȖB�-��rڛXI��qJ"�`4��\���	u��迫d֯ď���/.�T�SH�g�����$�\ �� P ��x@��  
 �
%
 �|	�&���C'}! �B v�V ��3�h>#XO�$6O��v=��e�g�F6��zp��q�2���ܙ��:șa�A�u,�r�y�ו���$~U�Z-�D��%��9>�'��|�M\2�D��l��`o�y^ p�	� L po
s �o�wEJ pEL��  V�us�!! �7 �� ��1@ϣ�h�O��>�HO��+=���t��:��@v8L���7��20�'F�{`�O<�ce��>��;�pK]�?�s��uӽH5
kL�0����Y��%h�X�ٚ��k9��d�(�4m<L��q����s�) �D
 
!/ ��S & 8�� �ua �K\)`(�a�=�5�@ �¿��#|Ff��i;z�g��	��e@�o!�y.�Z�$�O�����0�g4G�s�f�6���{�t��#ɒlI���M8��K/ͮ���l���-��2eJ6{��l�ٌ̙3�iӦe'N̦N��M�4)C
�+�q��T���q_9ⶳ����EÒ ��P�;]#��Y��:�u�� ��N �� ���^ p�H�w \.� �� ��S  �C ��496�|! �� 4���A>�b�O{�>�GO��'=�ӾDs6������q�ƠM&��Q�E��p)����7_���|��Y�o�Ǜu3��X
���u�"��<7b�\y6���Sĭ��*��]�NΊh�@N�CxLF��������i2��p�7�B�� N5���E(�L p�(� 
 �a�+gB <�>�q��^<;��������V��<	��	�v�E��=��f�O�>m�r�	W�ag�r�e_|��8�3����s9cڌ���9q���=�;F܌��ý=��c�A޿u�:f�����u��B��ģ�L�� 
O �<V"��-޿�O��M��@ �M���  SEL� `͈ L� WԄ 8	�e�M��5�:����G�.�B[��v�'|ډ��i7z§�?��
�6��u�[12�j^�^��8��0zc�;�ܣ��tD�Q��I�����O۝�(L�<�&���9�F��l���q��	� ::- �bgLU�����U�D������Q��Rh�H� ���:�!"��>�A
 �/ (� `�a
�  E�9 ,$��B �a��	0�������@  �_��y��f����	�Ѩ'|�TH��OrFn�WF��AZ���s�P���M��Q3�>��O~�6	��8����$�V��f�O�}E���6���$y���'�u��� �$�7-���Gr���ޘ�k�5/P��}�����j��w�c! f� �J�� ��p�� � P p// �WS  d��C��BK_F�  �_6�D�3F���-§=�	���'|ڋ���Ѫ�s��&vEj�v/D�"���`��{��
F͌�E#���Q��~��G�u�J����$~o����~7��u .�?��3������}��?���q�U�f��aA����_����N��#���1/ ��S & �� �#� 
 .�m�+o���Г���C��#��e����$|�>m@O��	=��F�O������}����'9E�;��ˌ�=�Fo�O��9P�f�nw
��������y��?@��#~��8-�T[�v��!bl���D���Å�X8������? ������vS�p���t���B$S �/ \*� �i  ���=�	 ��	0�׫C
!�@���O��m=#|�}��iz§]�	�vb@��چ�Jj��U��B��(���!m\
2������r����M�@΂:o� ����q�o�,�cc:�F#ͳ�~	�k�(�n����n��@���C�_Qq�!f�� x��3E� ��Q�:  \;�"� ��� �^LPX����+u�^�B�/ �/��������"|�~��iz§m>���s��L�鼕���m<�5�ߢ.�́�3-�z"�/R8������2%��׎��70}�0��Q>���h6ͯ�{��_Q��1e�Y��M �^� 
 �1/ X{� �ILP pA�����b`�E!G 6�{@�4�g�"|�{��i�y§=�	��!� ����H*xÿ���q�f+�u��nS�y���&��E��R����Dh����������Va�Ju�����﯁T�V�Z�=X�\g�m�|�FB�X�s��<o���E�yx׹�V?P����3�WƄX|� �� L P@�@���  
 �J \���f������umB`�! ��ߓ�i������h�>m@O��,�? ?���-P��e�*�G���1��N��l����wm��D�e�N����Fj.����O�_1���gV�[�g�`��5�(���D���� |#}[�'E���~+�W�c�ߦ�Y���P�>W�Ce�e�>��1ku���_���L�� ��^ po� L p ��=! X�B@4� 7�����I��i�y§��	�v`@������V�j\рVf`,3Ж�˒A�%�Vm~��v�ȷy�{!��#�k1��3��~
.���ǰN�	�\rIv�5״��e_����l֬Y�/��=���٭���Z���nȮ��
����E�?�S@�(��g���7�� f���?$�貿 �����r����2��L?/z^����0�6�� �) �g� �S���"��{nx�=9�`�b
 �,����gS��+�% �m1��8E���<����O�/$|�_�\O��2E�QрV4(�e�2��ۘ&F�$d�hU�����f�x��}�?��X#Q���u6��������"K��n�_���!�����Wg_�����ε�_���駟����?g���w3,��Z����/��F�?�5th�rfE$���� �+p=���?ۊ~\�ז��K��#���7!���l����+�'���2����=+E�Z޳���p�� ���� P p�h/ ��S t ( ��4�  W�� x` ��	!�-�m¿��y8��i�y§}�	���'|���@^��^J2AK.y�Rр�7(�E�s�A>$���1b&��f�匐I�ac~=l�t�F�c�i������7�so��ז�����[Q�e�]6?£x饗�'�x"�����o����H�%�&�r�\ɑB��]\��q�{������~4��g��Ο��l��P����@XHq�[kޏP0����S��X���L?+�E}=�9)z��O�Lo��5���Ey�L� �Rs ( ��� ��i�+B \@��O�N!�b�A�7a �K���6�'|�t��i�y§���\�����#5�t����"ҎE�6���Xd퉁�'��\����CR6;��ə������7~3�0r��t��[Ċ�� ظ�-i�s���$p���1���/���s�=�=���=�ܓ�t�M����/ޣ{@1I7���Q�����\�ז�M��g+�q�?/(
l�_[�~!�@�������$�{��P���`}���7�+V�~�T����툆�s�'vD��O
 ��  
 :9^ P�1`�5%� `&�:5%�1�����!�@*w��1 �)��f��n�O;�>�:O�����������RuI<E�1��ע�X�m�x��=h�H�$RdB�	�($*?ߝ$mѮ�.�C�=����w�'�ߖ��K�n���� �6����gvОŜ�����/eO>�dkK�;Ｓ�/����t��7RC�%r��m�8/?l������u��y��Nኀ��\��a(�B��*�W���$���s�`��һa�"���	��b!�.����_� ��^ �3@��� :ALP pv	��g� �����'L?�ƺ!7��o��y(���l9�TG���+F��=�Ӗ���,$|��������"�:d^�Ƚ��#�ЪME�>OE�� Fݞ�=q�Ĉ;$%O�E$m�2�����ȔS���HwS���p�w�̌���e'��l�3�h�6u�<yr��c�e=�P����6��׿ފ��&�-�s�B@��@w`Z�{q�-���7d�,h��	��H��c��c�/�P(����{e��2/����/zQi}3�QŁ�Zsb�Q��zVS϶�@ �� ��0��}� �B�:  t�L p�P��1��
ǈ玥S5	Û3ŷ�E��e�cu���\����<�E���<��~�O{�>�;��@��@���\�# REjp)c�����@7
�c-$v���4/:7B����y�8	��'uǢl�Q�{�#�y���ȟ=yzb��F��?�o���v�Q���u��N.��(���A��o�y���~��_͏�Q��Z%��	���E8�f��������^k((|�8F�[�x�0��g�XH9���`K9	��zaK7X��?^ �:%���q� � P p��# ��� 
 �� ���
��C�EF�!UW$a0((ph^dG�=��[y8�e.�r�h���F�O��>m8O����g ���;�y�����oނs��H�>�??(��2��k�(����5��0B7R�Qe*2���,�{O�7����Iw[��m;�탶~�m'���
�{w|�+_��>Ł�d�i|��{o����U��Y �x{9\���P��w�x;��h�[�ٹ��x�����2B���&L(�"�b������^ܙsþ2�5� �q�M��|��B7U�������.;Bl,�ߎ� � \6� �� E"S & 8�� �	�  ��0���(L7��R�U��܂���]�V��R�U+�c���k�6
Ĺ�Ş7§]�	�v�'|�m��iǅ����8�x��ifa=��c䞚vf����c��[�a,b�Y��"�0G��*���H�|����������'��<A�$gk��gk��gk��������O�"O�b@>"�X�9�XDe����ԷFⷶ;~�����s�s�k��!&�S"�0��h�4��"R�TmB�xѻ^<R�)+^\`���܂pfC8�!t��٧��Y�(�b ���=t���B �� ��0���#:  \P� �-�  �
H܇��P��&Q�5���f�^�~��� ��x ��>m3O���<��v	��9��pk�G��h�V��}�\Rt��=f���<{*z�@k��U�x��ܹ�޽�m�2�z�{r����0]'	ݑ0�ؓ�'q�<��͟�?��~/B7��(0g$&
� �0H�%x� �N�/
:��3��a]Et���Ϩ��ܺ�8Aqq�^ p/� L pև �+��D���& �.ƾ;�p�c��b� 5ƶ�>�K0��@�"�JvjT�/����#������'|�g��i�y§��<� �߃s1Z�=�y�|���26}ɇV�E�a!���f��/��D�ʻ�⹐��F�3�Q #�0�7��J�)�'٧H>$DO�>��Ϟ`�|C�������	���1A�r	������b��H�ȫ5���o���Y>e��QUw�?^���ILx�̋����T���x�q����(�|�{x0@���H� �z� P p��� @ �K8{�ؾ��쬄Tڀ��"��Wi��S���H~��[���� {��o�]F���<��&��",O�����3����Z'��$o?��v~J\j*��b_�U�s��yx����u����TE|�>,��d�y��?��nEyw#�0�O�=�0$�0�'���>E�$w�u[L�s�	�X���ŧ	�s�
�x�D U�*�)�2b ,��a�&�" 6+�P/NMX��~��)t�Y��?7���?g1G�OK� S��>E&x��� ����SIm� ה`
� �2�{�0@ �'(h��g=RX����A0�����D��I�wZT�/�Ew���)E���<��.�O;-$|�n��<'��A�
=��Q|,���Ա��D�6p��cֽE�~���Tn�WӇ���*�C����S��8\�'��P-,��yy�U�>I2����?$�2�����L����� a*����ʺ �7,r��eg$����)'���]�T��	{fBG�D@L �����j|!�k~���+)�C �f�{~�@��L� �r�^ p�)� ( ���@
���g� ��ŀRf�*9�*wU"yZI1�S�|m~g�¿���-��i{y§-�	��YH�̯���9>>@�$�"�>E���U�3B�EX��	�G!a�}�Ʒ��~�������>F�a�>���Ώ�1�'����'a�����=�>��>.�{�?$���F�e@������ƈ�,� �ᔪ�x{�{
�T��{��f� ��T� �m��P ������Ƌ ����V&%`����������0�W�7� �^ L� ��R/ �4S t ( ���	 �P���f���,PE@J���n�
��
T���s"w�/:�oI�����ioy§��	���'|�g̣��8�'ȸ,�{r�?���t��2��D|q^޴:#}V��#|?��������Xlj],�7k?��=AĈ?$�0�$y[���C�@5>��m�X~߻F�e�@;�ɳ��5�?�f�l�2E������7�����'�>֪D�a �^H�>�S ַ��{��o͞���s�g�j*��p����������飳�S t ( �� \�) :  \:! f#�u����P��@����*DOe����S�/�;�E���ז�U5��s�UF���<����O�>m���_��/@���	?��cd��";����ldV��è�~���'~^~P��~���6r`������1{?6���W���~H� ���c�HH^��Fx�*��(�#[�[,]��k��������HM�m�PD���2��Y*���k�</�g1�h}*���$F��%V�*���xG�D@́��@_` t����Ɩ�8D�0��{�x��C��@�"� �
�� pI� � ����j�� ����ϩ�aY'�n���#����8�'�VD��N�?J>�,O���<��	��+8�����
��!M�/ֳH?��7�����S{>�oѾ�H�){����M E�a!_X�o���rI���o�����:	%$�#$�f� �P�ln�z��s��e:|O�1c�5��.�����
���
��>��{/��'|O���o9��h��o��)��E�F����������i@+�	 ��O���  � ��!� P ؆Q& ��9  ܓ�) 
 �d
�� N�
�&B`�� 8��[dO#��F����ǁ�o��c����E���<����O�+$|��@����_D#1�!����6UoxH�>/��m0�����O����m����(+��#3o��*�������) Ru &�/ʺe�6�(�	�2Qy���{��w�zJ8��1��׈}�P#�[���~X��]#�ٛ�o}/�H��U���g�ψo&�=����M�y����S���	��s\���P � ���  �a
� ���{�0`�K��  ���v	���=�I���;srS�o?��?Ϳ*6~�¼�S �nR��<�m�=;:� �A�shC�Ӟ�O��>�-O���� ��p�k�88�!|>�eI�"�TN��}O���a���}n?���������>
JY�~�E����T�� �4 ������& �	��"��Eȋ���7O�E���p(��C����O���y�T_j:���S�3��/t����������$f��TZX���}��|�ֳ �Ɔ��O�1e�� �c��"^ p�/ �	S t ( �GIB � �i�J�S�Ł�����+��!Q 8��R��et7@'�v�,#|�P��iSy�g�>m���g�CME�`���>����1�O��é{6P��� !�{�L9�����ًsb],���g����ȳL�`*��K%Eʽ�{���E�y��.%���к��c�'z�	�1�G�a.���'�{����\�Q�w�b��T���'�0���>�'�{ǰ
�S��� �3��E�� ��#L�� ��$^ p�� � pO� 0.?�v6R���~ UD@*��a��W%�O�r��G�P�k#¿��F��iGy§]�	�vVH�����}��Xݢ=>TU�|{x���?t{��( 0�r�|�A�G(�����`�#�0�݀� ��a:���Tj ��$�0�@(+
�� �N�{��`��������!��aky�Ю��Cr��/E�e"{
M�����E|�Ų~�#|/���/���T^�ϞO�y���M��H?��OY�6qL��X}�� �z�=G�0�=I� ��%� P pO \	c�ch�a����� ��VITq � �'§�Q[�� �ϣ#�J�g~�"|�N��iKy§m>�[�s�:�F��>N����U��C���{��" ���@� ��#$�{*�o�_(�{Xe����^����6 �Ċc�����8��=��D����Ɯ�Y�{��竐x��.F��������H�r���>f�{����o{�/��m��U�ܶЙ��~����c���F�ݨ��:�k�b��?��{�x��J�� �^&L� ���t ( �?�T��&,WQ ���Uɟ\4d@7I?Z�<>�@�F�
?��t��@���X%�O{�>�+����3���'�<�O�>_�J����؏" ���� B!�G�1�?(��^�5&b�a�`8��b�o^�@�F(��9	u�D�P�����/���^c��>e��������~���=� ���T���a,��}7$yݧ��y�o�]*�oS�B���k}�� $�����Qj��6|/_��>���$L�� �%Lx�L ��?!p4�B� X�i kUs�U@7ɟ�yOS �$�<[�Ӥϛn�bY�V�Z<��\j~�~H���~���f�[%_���?��C[����(��W �A(V���(��)A���Z�
�܁�)HUf��$�<P$b�A�� ﵰ 1eo7�zQW��up�#������_X^�q
���"������D�'���K�ٳ#{s��ƂN���xa?�Zπ x� �&	S � ?0\ c��p洆b����'���Z�=#�~#�*�>#|#{=oz�@Q�U8+�=I§eĥu��w�K�÷����O�
�7�Z�CKU��,�0����TԟG�y����������7 U�A,Z��L�i�<Q��bń�(0O$x�C`�MHE����v����aZ$����{Xtg�<$�T�a��P{-��'��E�!��H>�ۗ��E�aU��cSH�v���:�#>�L� �5 ~! �����@`�{��8v�^x1���W��w���:�W%}^P�r��&�R�HlE��#���%XI+c�S�en�h-�p~�?��wZ*�VF�ۃ`J�%�=h1�z��ȿ� HRĢ_�p1As���S���>�
a*!�2N�H(kG����	����("�"Â�"!g�{���<|���Z�����c��1������7��D�.b�~�X�`x�1���Ƌ�{q���{�̤ �4@���K�^ ��q�gp�1��p�űmƂw$��0'�\���AM�U��*����U��7��O�G�f�����1��C��?l��:4�7\K?���-���y2I�H-��=!�:���R΀�^��:����!5��jb�}�<A�pBQ��<a��Tm-�2�<���)ؿ#�Xx�"��ϫ�/K�1�CR/|F�ynR*����?E�q"�qc�=�y��ObğG��o>������1���|�P PN� x�{�x`@�`�0�I��c?���(����V~/ ������$�WT�Z�s�UI�N�_��è�7��|ެ�d���S2��#|N!�*�ա��ǵ�um�N�	v�c8�D4��lZ[J͛@����MZr��u�h�(��y��Ɣ(0a�ʑ9y�O=d�Q��H&/�,#�'$ϲB�j]���|&}�x��=�ޗu��݅�wVi����>Lv��9t���{�ƶ�88|���A���*WC ��k �: ~/ ��A�v�J� � ��<D���v��9t�%& �#�T�*�x)�?��S�}���ַ(�*E�>(���#|N�B�l����qm�.�k��J�>�)�<4�>��܆9=��aG��A�	`�4�����D@�Ûg�E進B�lT`�A*Jʛ^[_ �а� H�'F4eDC�{��.����{1�Ƌ0���s�D�a��['�w)W+���+�]�<�/��"�2d�+~|����'���S|���#���"|;��7@ �+�K3x� �N�^ �~�``-�'0���a����P �j L ��?����)>L9�6��W���?���o���A�)��w@�9��{��<�M6�$�`��/��ޡ�4@��㘗�1��9H~P����ġ����������3��H��������e�e�ʬG��!��E��`�{'��ǪR4:s��71Q����S��^O�V�����<�/z�ˌ	�q$��OE�޾O���lK����f�q2;Vh�v�r�-[`�wl9 ty) ��>��X��k'�������=y��:�>�1E�)��������.$O�t�����9}o���͏1-d#��4�՟������}������w��2�5	�s���j���%���
/�s�/ ���&�L��( ��/�hr���h�(�
�6x�$S� 
����D��[�1���=o�VYk�GB�"�n�N��«�12/{�SEt)'���e�n�U��މh�LDs��U�g�y�X�{A兵'|�Z0ű4t�l��X��  ���`5 L�R x� ����������y/����S���h�+ď�T�&�0�'�����A�Nh��7t-}��	���1c�ѣG/`���Nz��*�%�X!U*��&فM x ��,?�X1�'f{hSe�p��'
:)��:���0HMy{2Ͼ�e����DY�J��T!�Bژ�n����_Ɔ�#�N��	�2�`����S��w�3����Mh���]o�3H��2$|O�6�r<�����h?� �L p�p7@y �  ����9�#�~h}�G���V�O�Y�u���H?������/e%t���������o�'~>ؾ���U�6K�����6Έ�ހ�m����� *Ov@��?;�uh������IH��h��W�1ү+��˸eR6P��\�{��U�	bv�򞼢�2B��{�e�?W�����
�E�-���W�V���$�2�<�y��q��c�C��Ŷ/܍��=�{[�S�8��kDoA�b��6F���1|�����e
� p�ߑ���x��$^�9�����'�X�H��B�����'��ѿ����-��@�O��>#���|mO���6h\(��D@�������{�7��*����-���C�7b�����/#���sY1PE�U?P�;���L/�^�k���{������{Y�̫Z�!��%����<�eƆ�xbǎE�>��T��?�E�#~#�����ml���9ns=�;�`� 0@ �����$�s�������~����gj���I���h�����OK�N޿(�7F��f�/@�#G����>�N���}���8m��#~#|���rʋ�C�	�?�~�dd�m>o��ౖ"�:b�l���Mn���e	�_���(�];��N��Q�R��Vy~������=e��7���@��y ���q-�Z�&|�ψ��a/ ��m�0�w( ��� ����C����w#6��Â����k��Q~H��{���E�o ���O����ھh$qo�$���$zO���"���/6�?�����k7�χ����=��?�}����*O���[g�l�=��"���t���qz�s;$�.�W�ثF�~l(����#���)8/�R ~������g�(��@8�Ǹc��0��ҧ@HE���9��ڷB�<����S���֍�{B���  y �o����P���J�Ԧ�h�3; ����:�����"|�`��큶���{�Z����C]f@�#
L@��	�)����st���ӎ����>^E8�{�<�U"�"���F޸����f X:`�,�mV�N����6&�����6f�|6.�,��u�{xK��o�(�o��!}/� e\ �4:�i��7���}.*,v
;a��8��M�E�aDo��<;`��	��o�uDA;���[;"��%;1��c�t��5'���v����zA�U��
��	0���O��p|��o��@?�&56��l���>�ˢz^�/����Ⱦ��}^�~�d��~� ��P^+�B��U!`E&l �V�(0IY��*��m>��-�����J��'�ߺ!��x;�j���_g����`;F]r��C�ݺ����v�~K޻�eE~�q��-;���/��_&\| :x��juB�4o�<��YU~8�����������?c��w�}�"�@,J�~v ;�5
�(���{�<���j������� ���>�|_Շ�� Ҏ0�A��A�]'!5�w�P�9n���v�S�>�.q���D�C�U#v{�>�Uƒ�cT�x�
�ڭ��pH9v,�m<�:��D�ȾiѮ(�`"��&)�P�:���EB�����/z8�p(��y�R恮:HXEUq�⺃`;i�����DQ�x�"�~=nY\:��Nwx�v�p]B�jǇ�b���2֔Ê�B��2�l�8m+3���e��E9�"�/��6��G�D@��@��@W��b���T����(�9U�BqP���@�(:f�Il���n��L���v�{��*|oYB/�Z��'e�"���Z�ycq�/
;E�Ö��C�	��b�Iw��!�<�U�A]qP'�P��� [e�n�� $���ɵs��|�L�*��vȼJ~=$�:�|�1�
��e"�N|�H�,ɗ��E�5,�^
�2u�
�(�*b �)(z �>`U��?�3P�#:!�\`��������[~Q�N`U�~V�L��W	��Hݞ�*�n�:��e��el�N��6���#+�E���V*�G�@�dz�l�@UA�MQ����YGԭ3h��S���UH����	����c�k�s��~�*a��_Wp�C�U���`�,�w���F���D�C6Oߴ)#ʊ����UEAU� ��PU$ԉ:%��ةA65��`߫�U!�~~o��z�n��vI�]2�K�U�����E�� ��v�H�i�/q�N��n	�*5�^��PU�u>�UEA��vD��l��n�uI�*9���ŴS��V��q;�\��l����!u�?eӢ�}e
��X��uʪ7~)AEzK? д �RGP'}Ў8���� tK,�B8�!�N����1e���{:A��1�%�{���>�M�U��*�{�^V}?0w���� ��20uY�hĿ���mG�I)��n�[�S_;�
u�n���Ym�x�W�{Y�s�쿝 �j�:�u���ǹ�cd�Ƚl��"�.�`>l?��:�A��]��tC'D���\����X۝�����1:!�۵�C��K�eW��-UI�j�^���f6�k�"
�Uk�u:%�ubQI7�N�4�%�n��$Y���.�:~/�W�9�e"�v��n�^'��Ǧ�{[^�{���p��^�v�A��	�4D' �2�^;��� _�<�"�~:O�z��v�Y��v�٩�*l�vo��됺���̪C�W��:��n�A̪kwp����������􊤆�y�}����}���W�=�L;�M�1n��
B�}�<<uS�Cމ��S�Bހ������eC�Yh�nbPt����Nv���N�x�|z8v�?�B@,�@]��	'���!��5�����6i��7�o:)�;a�Ǣ�v��B@"�}�!��ԭA3�M��ι�BMb�D?k�>O}�S�� �t�B@�
�N0����A��l�(˞�߻���Aw����٫1A�B@�"�i�;^/�:��5������ן�E?�P"���|˞��ģ�-�P��`e�i���B@�!�@U"��Z�i�X��B@! ��5��K	~����    IEND�B`� [E  @   �� S C R E E N - M I D D L E . P N G       0           �PNG

   IHDR  �  0   V��   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  D�IDATx^�ײ�6�����k��/q�`.N�d�s?��s��:o�����'�lɶ$g+Yٶ$ˉG����2�u�k�A��b)�����_w�ʁ�羯����k_�����W���a#��򕯸�M�ap��Z}�V��꺌~S��i'i�ڲ�r�,�׶�׎��s} �ge3�w�K�F���i������W��r����n߾}�����C=��̗�9g&�������ԩS�����Cq$c�=���<yr�<^y啁u����C���K/��K??z?��k����t���k�����s�o�1�;�|��a�x뭷�������w�yg�;Μ93�gϞv�s���������q�az�����q���az\�ti��/_��ʕ+���z��0=�]�6����ׇ���{��������>��ƍ�xܼys�[�n����q��x|��GC:>���/�O>�d�O?�t��>�lH���x.�9�O������~���~��;���&�ӵ>�/~����İ���$ڳ
�
;�N
�}�ZGA�$H>3z��)7^s϶W���$� �$���3�v�� ����<��3���J$�����M�5�#�)�A!����w�V�$H�g����<r�sc%�2#�(�!h�L���HT��#0U�K�i!E&�}��v���/�������y�q��a�5����@Im0�l$ ��J�+!��!�t�{΍�}sž�A�I�@�6�:��$: �LS��KiM�@��R�� ��kl���b����M�5�3�ݾ�!69P.��8	R�G?K����3�S`%@/��R���3��V�:*0W#�qR?�=��?�й:K�y��/z�ݗ5������r�s��w�h�_b�|��?�M����-,D
���"BF�ྨ���AID ."�@j����կ+Y[L�9`�yh�-߷c}N+␃���Hw�#p��дr���'w����Ҕ� +r�
,�VT@�r �4��k��U�,-ۉs��4Yݛ��aMǂ�<�89��;o�  Q�9�95�I-�!@��%�K��ҲBtI!#*�[B�o�`��_��׳kS�M�V��~�{-���3b�D0������AȁZ�V�t��%i���!@� �v�����}$��H���.�c�-����ط�&�~�V�E������T0��RgA�(H#	���8��A�:�>��S�nR��hR�Ȁ6EP�8I��m*��h���7�����o~�w�H���~+��u}������c+��0�8
R'A� �v�9l��%�:��@��p�f MXD�S�ᩧ�jS�_��'f�g۷t&�~k�^�clX�a�,L�e9�΂�Q�8l� �\� �F�׿��`�>���s�#�h����3����"�Ц�+Rw��ɖ�9�[MX������};ߟ��1׿��p�΂�I@�9@�%���S�ԯ4u�:Zg �����L��
j8��2��דO>��?��o;�������}/݈��I�����?����rJ��� q��A�1���t�Ǝ�3��XQ�}+R��'���^'8�s�/�}ߛ�j���{��s c�m�v J�� uPq��A�c�K!Hk
�>˾�A!Ф
������{[aiT 9w��U��s�Ϟ X���T��[�q��טz�/V�L�/빝��4�8
'A� �t�[&k�I-���+$]���3#K+	��,G ���㏯�ډ�U;O0���������p����s�vJ�� q��A.j�����}��+:�t���Q���c�=��5'
���>z�f|�3C�{�i�J�YԞ�4h���:�s�DJ�S I�)�!ؽ���C�3�T<Ȍ
��}��6���7������w�`��y����Rsr��Z��V�����|^�y`ؕ�#���΂�Q�8	L��1о?a������A�3���齯��
̥�s���e�$׋�V@��فu��m�g��i(q$N�9@�9�`)Z�q
�2��|�����8K�
����9^ZA��{�G�)�������C*��ˤ�~�d�c?��:�}n�܃�����g��N:w,ٗ8G��A@"9�`�1����H!�620Wh�`�#�Y�Kx���N����%le0���j�<X<��A�(H�s�sj;��	J��C�Ф
Pg`iY�t,�FR���>�d9_��/)~���ϖ�z�-�c��w�Ɍ�X���q�>/%v%sɴm��`�$ �V(q4�i�`�s5s�4�@�|�T�R�Ҳ�}Q��߱c�ځ��C��]z�Jt˶�M�K�#l��{��-��s_�0h���Fj8K��S0%@�9'a����p��IVL����@���ѣ}���@���rb�\�w  ���X��C�{�|_-m$ώƶdNۖ8
'uX�A.b�-�8��	�E	��&:0���B4E��t~�CR҇���Ѧ��Xr�V�����{_2f5m-怒yL�(H�s��,95��� ]r��,�h����<��C����G����XҧfB����dm�v_z�~w�v��@I���bɼ2��:
R'A�  �5Xr�N����\�`�!�F�ځݾ��@r�R_?�я����p0��� 4}�Lf-�z�N|���wR{�k��}mJ�2�� qP�����}���nt��X*L�f��ַ���?��O��ǥ~i�c惉�U{��\�zn���-W���C/����wmͳ��A���`� �����A���h�	����ɩ���F��_�p��G�v'��g�>�9�qJ���xe�g�%�T`I4z�sr�S���`.J�:H���8q�������&���ޒ����/����dB���ҥKC�����+�cR{�|i�  �A�c�q
���:H� R;�+$�:Ǐo�?��Ϫ'��������_�!��r _�|yh}l�{C�q�Mɳ�۶d>�ο��:K�k� ��:���>g��^����S�%�/���̇�����Ģ��&������u`<�]�g�d�Im5s��A@��c�}��>�`_=�$J�8���n� 9.��`�6�Fi{��]ۧ���ƻ`�r���5|��.��>��v%�t>F�s�1���9s)�H����n���_l����t�H�Koi[��W�G��aٶ�	|���w�Z�e��d��̗�����"l�@%`:K�@��>5�5��Ѧ��(mk�k�l5١�p]�^�ǝ{��X@Ǻ�N�����iҹu� 5Xr�N�!@��3���|�r�_�t@0쵃����+�G3iX��u�?w�6��}c���f>�%s�f����sP�����"�� I��@��\��ӿ��/f[�jZI����і�����j��\w��v��G�=�>N$c^c[2���yM2���1X�h��}��C0WT��Z�ܧ�dP0l����]�CW�^3QX��>�}��o|�x�j�s�s��w4�%:��������)ؗ:�v���g�/��"v��V�F�P��c>إ}՞�$��d�_�>�as<��s�ږ���fn���(+r�A.b��)�FҞ �����o����_M����f�a<t%}��C-;ϓ�� ��V�k�1�z�K�ɜ)����1�8�RsQ4B0��"��G��٫_~�Zj+hے���-��.��D&�֚a��{�qԽǓ��@�K��V3�I�b����R����A��?W�G���dp��j/�M�C�m�L5m<N��� �����8c�g=��yG2g�s:�c�-�8��	�sAZ�w�رv��o����s�A��R;�@c�j��v����$��k-�x����8��/��ܤ�J�ͼ���(r���c�t
P� U�w	~�)�C�N3�Kڔ<l����O/�j�s��yM�In����>�����d�D��cj;s��]� -|��})�܍d�G�T��d�1l�Ei;�C]�O��d�~-`����8����Y*�4�:#|��j�1�D
���A*�{�GN���sߝ⾟���W-���L�aؠ�a���mJ8F[�����$�|���2�oܸ1�<��} ��F�����s�d�D�t�1K,�8�RS� �u	~�2l�/�a#p[�Qڮ�.i_2Y��5!ײuZZ�A�3���s�d�ͱ!�(+� -�s	��a��}1��Rj+�{�Wڎ=qh�k1iJ��<��͛7�^�5|o�q*��>��v��G2W��x�/K��8c� U�?��mB����w~��C�N�Ɩ�G�`��d�1l�F�=�a.�C2�X��<�����2G�Řd=gڹA:��s/%>�8i�_��/w�=��0l��°��R{�Wڎ5a���b��\sK�u�ְ����W2^%�%�mj+�$�$2��R��*��{̯�ρ��|���#_4�F2�Jm�þ�a.i/�tj��0�O?�֠��߷��d=o��A:�!�.���1E
R�s��;�>w��/�a���t0��k��6�ɢ������Z[�և~8�q�x��%��-yv��d����9�,1-�2U�?�����?���!��y�s}�n4�|��f���R[��Qj_� ��E'k;�����n��5^ϝv�@�5t�ͱ`�G�ui�_�ρ�q��>r_�<:pv�`f�i��v��B�G�	Qs�5�����C�{�qh�r������=�<���K,I�J��O<��π�R�`O�3���3l�AXj'}8����]n��y�㤽�3��^�=�5^Ϡt���i�|���_��@w����}i9߿����4���v|�Rɀf�J�R{�$Q�G�	Qr��@裏>���cC2�[�3,��92�$� ����������� d�I�R{�\��dj�x���>C ��5�O˱�x���d>C��4����'�|ҧ���rυZ�K��k� ��dP��J8�=c�(��r����|���C����Xь�6��W:� ��8g�����z�-�{<�K}��\z�m�d02l�I���a.mǚ�������������=FƑ�F�l�v���˦�lJ�w~+�pϿ��\��f�i��6%EI[��fծW�|��'C��A���|4ϱd�ٝ�ؾ�W�����G��*����.��A��<�h��a�y�K�0'���jO��������w��/�]��%�#���ҧ�~����V͗�;׾ܹ�(�K��F��>x��%�Di[�dfi�#0�g���O�pvj�%�s�y����n��~��?����M]�n��R�98������|)���(�K�J!-i�y�K�0&��>jO�����:(�}��P�X�}GǙ�N��!sDb�3�<�F�? o���K�0�ڔm/��y��6�I���d��� 5���;05�T��!}���t~+�������̵���cC{�?�]j_:���9�J�����x��$���>ki�p� ����|�*ϵGUw���۵B];I��C&�6ޡ�>_��{��W�3��'�<���B�����C��F�!��%�F�j`-iS��m_
fM��I����+��_T�'�x��o�~�9K���/-��׾G�� ��Fj�m��`.��@��M	�K�2';M_�)��H�~���{�9��? s(Q繶%�ε� m��� Zڶ�ڶ�I�i+�,�^~��W/}���i�m� ��s�.=��Zjg�%����Yk���]���������^�z���{WcT5�/�0����0}N�kϗ|��ڨ}�=�����v�Ɉ}�����5���v�q�%�����z�����T/q@��R;K�#�[k�U�v�&�Z�Pn�Y��Z�Vz�Zc+��fwF�x��7���S���(��*�\;�;)�����z�5)�Lh�5B{�wB]�qcu�����vN�i��O���7�	��_5j=�XM��~-!��^������������s��Sy��h��h����_|��l%�S���x#mE.��Q�[>D��mg���������~��v�cݲom�-��>���>b�o�Rx#���5�������!�&�[�+O@��ھ��c���������"�� Ж�XA�b�k',��%�-�`�/���������6ϥE�V�R����Q�����
y)�{�o��[N������ w�{�Z�[�ե�-���>�������=h�Z�#G�<���/����_�s_j�Q�6��6�dR���rҴ���y�n����k96��m�}Z�}J�°�=�� ��駟n�e��[��Ń��D'���Dj� ��]�{2�k�]��k5=�jn�􋂧W����u����@�������T��`�^���H�Z}����>,;t�mJ�bپ\�|���{χ��o�Vp�Z������n�\N�e��	g�/KK�^#H-�e���o�'NP�@g1�$��ET�2�Hl�&Z�[A- ����ަ}Z���`�<�,[dα���kY}Z@s�}^�~}xꩧ���5�g�i?���pO�� ���t�@a�� oqj��-�ٚ�Ξ�r�Y̧�>�Xm�z�v׮]K�?yppp�����}���f�|�\@���
6��w��S������\�9�γ�LI^^�ޯ����ڲ���$��s���$l6�{�s�����1.�e?�[���{����x�ϫW��W�(���|��!����-�'k�.��~pG�8�MK�{�8�����<����������!��[����r|�����-<{,�Ȼ[<��>���\_%s��m���yo�M;�<�\�2<��mr�R�J�$��[bc11�A����=�w+�[���O�x�ز��Zp���Ķ&�k��[��ڮ����D"��r��s@�{6����؟�8J}�Ư��39�ɜ;v�*6ڶ�kA�5̭ ��7��W�|����O�P�̇�=�h&��6�	�$l��0l��w�Mų�y��,�P�(��v5��f���[�OMP����/���b�%ǀ=�0'@6�Slг�g�f^��߹'�3�������p���J��%m�Pe��v�c�.]j����gO2̉�z6�SL��Pl������=vz�3�~c_ZU�����^fM[6|5��a������䰡g�g^�����������2��Zkc	xK�^�0k�h��jÄ.�������x�bR����ܗ���?{�a���{�fC�	=��zb��[׳���_(�[����g�k -m�4���~��f�s~����� ���w��)��g�7�[)x+�[+w)���(�vZk۱`��'mɻt�����?�N�����U��÷�I�h��9=K��=;��v-r�=@^�ϵ��F�A
k�=�HZ8K�1!��+���]�?@�=Ŷ���-9���ة�P�9Xk�[@�7/���s���{�K۔������~���@��z�8�Z���k!����Vyx��ڨ})�s�5���)��=ƒ��^�%�[�3'If8�h���/��=;���#��n5\oy�?�yNj���%��lK@.m��z��/G�m�Q�g�_5�U%��QE.��)p�y)�%�%�F۲`��G
d�}ڋ�8����c��+�{�W����j�l��-��{G~Ԇ�=0�� ϻ��%\φ|O*^�\;	�%�(��v9 �γ@��'r��.�Ϟę�A��ؕ�ض�w@m�߁�;噊�z�j��p����ρZ{^m���H;�����1���s���W��A�����彣G����{&�{P�=(y�R-ė�I�-�E@����H�}�[�3aφ6Ԧ�v=��b���ラ���٠���{P��O}J���j����<K����B��:j��̉���:l����{F�.@�S�L5���z�j^��s��@��ƦG��Bi���.��g<Ξ=;<��m��|���O�<I���n�M9��z@>?jþ�LG���#?w�y����<��%v���X�J�#p.�)6�v
u��]��	p����{F>?bü�[*�c*�P���j���:��g�y	�Q��5�{�|	�sm@km�Kl�?6�P�r�������3���u���7�i@�k#��=�9y�sm, o��s�ׂ֞i'��6��/gΜ��g��jc�겞�Ϗ�1�=[�{��}��	����BG�r�֜��Z���!���h��������ٰA �ؔ�ض5����g�z��g�Ć�������g��y���@<�& �/�C���Zc��:r����A ����Z�;��;�g����\�����=�U�]���[�<l���H�Z��J�w�ygx�G�U��ϩS��R� �Cl�(�o�|~Ħ�^�g�ޫ��J�>��f$�8b'�8b�=;'��k�K��G`����;�.�}����P{d뮀~~Ď	{&跠Ꙋ>�������|y�^p�M֚�9��;����6:۷B??b����?m��=���*z������.���s�\z��F�\-�?8����+ ��a��k��\}�zy�>@}� ~��zMH~���9{)�����ـ��p��0=�~�m_9~r����-�Ϗ�0a�ᇪ_���(vĖ{I��Er嗀�Km���=n���9�Z�߅~���#�Cl쑭���Q���l|Va^����z�]��ʠU�9�.9/8b������瀎�_s�>}z@�7g�C�}���i���a����\=��Q����aN�^z	�[�)�s�lУ@G���=�uW`��+�V�T=�mvL�{���
{D��6L�o%t��[b#�8b���w�'g�����o��V�?��u(�o�vد=_��>��Q;��;j�B�c�>�ń=s�6D?�N�-n��∭w��B~�߮�o�m���C�㳔=�LU�\n�B�c���G ��0a��'�� .9/y��7j��sj�K��Pl�*`�&���G;j��<g���i`�z���/�A@s�u�ƅ�Ƕ�
��}���A��Q�#v9�K�{�=��&�%�=g�S���b��yW��Q�s�����o?�p��������O��{�	��=�	�Kl�P�g�@���<g�v�3A�T�R���s ��g�U�
q�n
�ݿ��x���V`���|�W�{�町�|ޒ���l�J�?`�د#���¿4��=��/T�#v�RGm�}�ܦ�>`���:
[�(�%[	�s�9�.9τ=p�
�]����郃���U�g�>��ucti]�.��݂_{˪Ɨ��s���_|��[��K`���
��%�%0�ٞ={v�7�x#���,����׾�>`���>Wt��_{�	{��O��Ժ�|��y&轆�s𖞟�~���c��P���}rr�=�>���0������|�V��s�R�/�����w���������,eτ}r
X�G��!v�r�م��_~��O�¾{�ς�׼}./9꾾�G�;b�����s���a�T��/�?��������.K�#Gm������y��|�����9�\h^r>�G�3a_
�i�3g�����p��1��}�~C�^_��f���:�Do�c���X����|������7��� �a��?n���'���qP�؅��W��/�������+���{|�����ߡ�H��"=��ځ���)~o���O�!)��ٲ
�X���*��D���#�����O��٢0�������sM��>����J��zQ��z��:)����]����>p������>`�F񗀟|��O��;z���S?սǼ=sͽGu����Gೊ��U��/���� V��F�ϵ�J�`��	�߆���̯�G���K�a��W�J�{�U�9�P����)��y�!���Z��|��g�#�S���=�{f�k��������}��g)��%�s G���|��g�>�=��ꥴ ���:Ԇ�GT;j���8�/����O�!?��;���b�(֋b����� ~ ��w�����}ا(+�q���롡z��c8���y�=�������ԩS�����=�:?���X�	��4x~��P�^�}��G@��H`?���|,�����u�Q�K�.�K��nB����3+�ﺏ��bg��Y�� y^�EB��M���.��I�=z�����r>	��|��G+����Ǫ�מ�O����<b�1�?|[^.������o�=��������߃��e�E���hm�d}}��9b�_��{	�wm���5�Y�G��E�`����X�U���~�a{�!��G�O���,������>���,؇��?������~������ҟ���P ?���Ӏ��{סu��$��B���H��	�__�3��1*��Q�'O���0	�#6Ώp��0 �x�M��#��,؋�>�)`�!�g�{���#0Gl�� �l9^�!���B��o�\���|I��R�޾��"�#0Gl�� ~ ��z��lѐ}�n����۞�mK�{������	���� �|Ýq�dS��c������E�G`����� ~ _��o���)Z���lZ��ς9j��������{�>�x	�KlZ���R�(�� ~ ?���̭u���sR=�t��%{4d��EX_������ӧ�n��%ŏ��	���|ː>sy���=�a�P��[����zkH��0G��}���<t�=b��u�k_���\���|�=�~��������}Ζ�g���.���+��� ~}��ֺ�ֺ�q��\�-xw�zɿ%@�٢@G���BX+*������<�  ?��9���o!��5�*���go�k����ǁ�^��z��G>j�q/��_{X|�OT�#v%��2���w�&T~����/����O��nB�Zſv৷�ޖ�v�'��ϣ6k~���l��yy�x���{l�����G�߾}[���ܫr�h �9b�~����`��\n^zU���W�τ>s�3�п[��������^��o|���l���\~@_�Lo���w~&�S_I�3��j�����P���<�װ��Mx��{l�3+��*�sh?������u�K9~&���ҏ<���<?+��\���J�f�����(�a��C����Gv�Cm"�/�}o���t�C��[��Q�����y�ʗ��??����������|��Y峖�EX��<��/���@o�)�Cm��{�\��������5�) U�.����/,�B����C+�;�
�a��=�|�a����^�3:�|�F�/�	��G�k��*�/)���2����Z��h^V��+��J~ɞ��#����~E|^������|�y��������K��*?
�t|[
���W�/� ���/U�k��~��#�?�`V��o�����#�/�g?�~<ro˓�g�]ϛ��Z񳠟�K�GX�]���5���-T�U~@_�g��g�mU���]��'Q�,����o������ˏ�~����Y�繈��{�{U���m�Q�'ۄ���=��*��sC��s��|���֠��YЗ��[fh�k�O�|y.?�П��s���������?�֗���.��uЄ���tQ�X��#����/[�o����;�f>��� |fX���P��}�5p���9b�>[�;�v[ډ/�σ�E^���݅�� }�a�P���x��~̥z^�﹀�]��~����z������G�?��C��sT��o\ǿ��ʗ�Eh?B��]�P�څ�?7�V������H�^jc���E�� �K/�40���Il�P��T��__h?��.�o��~��[V�=A5�� =g�~��u�|�U��z[�>[�Gx�l7>�]�ƨ���~��S�����ş����W�Kߔ��Gސ�ڠo�C���6=�k���g�s���о���i����~���B=gτ~�ɕ�W�U~@�Ґ��/�Gs��]Џ��A��_����>]*��%���о�����y�e%��k���	�s����g�~�WOз����w~	�[&�����|}]�����[�oU�[�����Y����o^����a߳ʏ���k�١����U����j|I�O��K��K�r�������E��9j����<�y�8�C�P����G� ���m�E���IO�����<�Q�#v^���r׳ʏо����)�����V��^��n?r�M@��Q��6��G�B�����/�a�w��w�o�^��}����&���V����6(�Q;&�S_�>��?����s�R�#����z�~��>��������
���_�/�0��}s��l�����7��-�D_���s���9jЏ�>���u�=A?B��Mzj�ݷ��oB�8q"��ݸ1H������Kl���Zx�����K��B����~�_�&��_��?S�37�aW�3���)���z��*�YGi(����>{���>oW��+zsk��{[�?����Z�w���/�a��	�-m���K�Ie>j��
~���ôA����~� �>��[[���{_�o��E�GA߹A��s��Ծ���a�9��@?����������Q��|V���sg"��������ѣ��d���g�u-�r�}����P�e�՝��#�~`�M��̿�T��|��_���
����.��R�~k�{�~*���s�h�^b����>�Ӿ��﹨�:���)���X�{��f9^��z�e��_^���g9VзZ��s������)�߅���B��+�C���7:9�.=/Q�-[�[-ݳR��ۿ����5�ݕi���}���"�S�����F�g�J�U�V��m	�5�k����p?���G*�G��~�6�cT U��P���|c� ��_���r�|���]+��~@�%����o��W��Hxj��l��n|�h�ޜ��B>��~@�}��?���0�[Ò3��l�{�s��\/r��[�Z�o�A�Ų�^v�������k�����]�?���[@��6���9�|˼~��C�E}�������{�4��ػ@���경^Ծ�HOb}����,w��^K��B�� @?�/)⳪��j^�*�j�����zW������_�#�_V���[(�-��-r�/��I���a�5���h�`_����H�i
�#G�<�ĉ����}�:�6鱀~��wK������?3��{�>���dy޾��l�|���v��߅~���0����{H�9����������P�Z��K^?���/ =�gR��%<s�Xnܳ��߿��{�o����J�y�^��{S�=�ݷ���㯱��&�k��T���+�(�����j�O��?|_�%}5��.�������u��~@�$�!~c��E%����5�������@��v9X��k��%��ہ~/K�������Oɲ<�mo���O���~տ���o�:�o��ڞ}�<<�衂?��W��gl�[��{۰�Z�G�9�_+�_3�_;ׯ��w~�j�	������y/צ4���={�~���i���~�~߸Z Y�Wj�_�o�R�@����w���[T��R̷�o}�//�����[/髩�k�~�ʿ��}��{
�[�Y����ߣڷV��|��&��{�>��|H������>#��K��
���� (~mؿV����o��s���@���s��[n�k~Iu�ԶG��\ѿ�PM�_�u���D�[��S����E���׏�Uz��"����R�G~~���c�����Y�`G��n�-���
~+��T��[n��Vj��{����R�5
�j��Uȿe�7��V��#�����V�a���,d��g�/�P�5��_�SsY_����Y���[���C����n�a�C�[Bߺ�t*��_��ߪ�O��;�� �����-�j�����XObo��r�C�~|��������$?oe�ꫯG�=}ppp�����}G�y�ĉí[�>?��O������U�V�g�����%|�?�U�����Y��ז���\��R������=@?B��+�[@?���u"��o]�����z�"	�u��v���E��?[�o�=�}��~������a�1��p�B����]���G����{���|���7�Ea_����(����ZE~�B�[�s�?~�����ސ���Cu�M�߶��r����=5��o����� ��uව~����~���������{�*��k������ �U����T�gU��[n߲������ ��pOcߢ�������ƍ�%	���b[�(����ު�����Ǖ�����_s��a������9��> ��kl"�o_�g��ŏ)���k��vȿ%�ר�������B�����B�R���rQ����m�k���mZ��=��X�C��#�?,����_+�_�5��Z��P���큵[�v��C?��anߪ���¾����%}��_[�o��Կ&��	�[��#��$0���G��ͅ��#�/_ϿY(�kڷ�{�������ߧn�3��GS�����~�j?r���k��������N �K۴��@�G���dk��)�߫������<+��B\�>�o�������S�������-����|��r�Z9���_s��U��u����B��ߧ������wu ��������B�/+�Z��	��~�3�����$�K����j�:���KC.j��i�|H��"�1��3�y�{��k��6;v������w��?�9r�y���z�~o���j��0�?�o�0^�#�������S�߫��o��"�o�'����_�6 J�x�c��[��S��Z%��C�:��������Զ��w����)����Ծ�kw-վ�5y{��e~��¾�s�5
�j��k�m!����Կ�@����P������g����.��?j`��kU�����_���[)�������@����?ܩ/��˩���_��P>�O�pm�ߪ��CџG��*�������}�0�����������ڪ?�v`T�}xT��� �|`�R���~�-z{ޱ�FE�5�k��'�a(�HC�����Ga�@�R�Q�w�:_M�^��2�o�*� ~)߸* ��/�CB�,�R�K�3`.��%�[���� l��~K�[V��q�Q�o!��:���^��Vŀ��ߛڷ��������E(��}�kV����s�-��������'���r���ﹰ/�2�k¿4���g���~�!{��4dϰo���?���h���0�a�?�?_�?F,w��Q�W��/Ty���i`�\�G���(|�ءN�k�G����x�#*���#��/�_;��"�?: Rp3�=�ߓ��p��Xr��7{o��|֡� ��kU���� �� �6���u/��N�&��c��2�/Y������-��p����_�c��}h��h���� ����0�0�u~�z��P�Xq_M�Y���?7�tj*{�Z������_�;v�����;G՟��9����Ǉ�7o~����H��r�Z��F���hh�>Î��%}H;Ӟ��5}���ܵQ(׶�����s������D���<��,_�SsYߚw�&̥}i��j���u��r�m}�%�{T��nܳ�P����oQ��*�߲�t<��k��$������$�o��-���k�k���_����X��' �[�8� ���֢�k���3�9|I�\=�V�gڣ�����" ����W��z����y��V��R�[�{���$/�Ҷv$��#�o5���}��C?���M|v��^j�R��~�J^ӗ�����1�S��� �P���ſ�e}k��oU��z�߮c���9 �)� ���<?^���57�#R�βרuf�B��@^���i� ���5v�[�k������o��9�P�����5
P�\��-���o�=�������o-��p_���+/���S�Q��m��@�?(~0�_���/�E~���0����2�q^�Эm�G ��uNv�� ?�֛���6 ��[�ٿV�Gȟ��>oo��u(��.��`�N@r
�x�?/��5���ߣ�
_�����ȯ���������	��ھ`MN@��?���|���9��S�5
�B�����k���|�/M��զFX��5Х��� ���#�?���gM~�QX��X ������N
���9 ��8��C�¿�P����_�o���Eȿu���п����sN��^ n�e����|֡� ?�mﴆ����5+�������)PC�k�ѫ�5�/T�5����-ſ�p�߾�7E`җ���s�6�; ^� ?�5��T��1����;�r�Fu�����ع|�?m���N
��5`���Z����� ��Z~kU�[�o9��1�?:Z8�j�&'��#��I�T�c߈Zgل�/+�k�o	��o��Fj�y�5j���:ks,��N���<��+CiQ�X�_�����G��v�~I_8�hS�Zm�� 0�-��WU�5�!�r��r�_(��"�0�\���ق#�F�� ��%=���*^Ӿ���2����=��=���aؒ0!���Y-P#���<�_�Я5�C��W���:[t�|�ʹW�������U�;r���Ǐn޼9���O��|5r��6�Y+�k/��s_ݛ�(��[�Մ�k�a��[��G`3�_��}5�_K����}i��!���������r(j�\{� g\s�N@���՟5�S�Z���Ski_�ʿ����ݯ�����[��G ���Ҏ���u{�����lM�����ZX��k�k	pֵ{u�� ?��7�P�׶�����`�����(���5��5��֚��Rȿu�߃�������qi =���g_���p�M}�����v�U��8oQ���v(�q=��ڴt�D��/Ty��k��%�Z��=(/��s��� ��C���~���a--�G��ڀT�/�Ԭ��M�������R�����0����&��f�g    IEND�B`� �  <   �� S C R E E N - T O P . P N G         0           �PNG

   IHDR  �      �S-�   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  hIDATx^�iLTW�;�B�E��*�"Q@����+A�"5��X�K�qa1��@PhӤIM�ib���i뒴iMԴ&Mm,rzΕG��y
���$��af��~s�9���3����;A ##Ý$�`0��6���=� �z��,O���ǨQ�\����ѳ���g�������{ϟ?�˟��c�����by�N��A� � ��3X�lY+���ͬV�^ݝ��K[�n��;wҞ={h߾}t��!*++���Fڴi555;uz��!uttP}}=���ѹs��d2��l�}��ɓTQQA������_����6l����tFf�3� � 8�E��Y�ŋ��d���̤-[�PII�r���#G��ѣG�رc깼.��j�R||<�ر���߼y�N�>M555TPP��c�޻��Ǐ����@����ZHpPqw���5k׮��i b�     ��fϞ�*�3g��y��ъ+h����^�H��������Y JMM%�������ZZZhʔ)�������]�����H|&�>����$��h�ҥ���|�=HH� ���w�޽�����8Gg��� � ����6m����5}�tZ�r%���Ӷm��Y�8���d fΜ���E�f�"��=	 �:~�h���W��:���׿X�p!�$`�Xg())II�3%%��L�
�ĉt��)�������`��a�bb     �&O��E"q�rF�f�Z�`���Ptt��<��������#�S�Y�<&��ﭭ��s�����ו�3��q��Ɗ��!�U0w��*��i��՝��@����+�\$(ظq��Hi����)�    K 44�װ�0ii���M�8���9iҤZVfdd��������k��@<x��}��������1c�g�Xf�,��e��ddM�!��`u����}  ���(((H�ݥ�?~���X�&L�K��z����uu5=z��ܹCW�\�����v��a�.������8�@{��U�.M$��'ƀ � ���$�����7N���;}}}]��K��Ϟ=�����oݺ�V��"�t���q\�(�r�,ܵk�[�N�g��>1@ @ F�Y���.���q��^C���$Q&利S��Xp9�_��q    #� w�{���J"9���~/���}��*���v)G�BÜ����rD��yb� � �T���Dnnn�u}��'�1T�����$!W�%�!!!���;@�{|    �N�Ls�...��$�^������s)⩔#d�4�;v,z����0@ @`D���l���(88�Mo�(?�#bX*#!��K�̘1#�W����3�6�,o`�o\'�=z4i��~�B��;���=x����ڕk�;;;�ƍ�����ѳ?�7����������<?rwwoл?�~;�w���Ιܒ3��TZsB` ��`����]I���"`�� l 6�T6�X����÷��\ؾ�L�l 6 �8��������A` ��`����{ipC��)�� l 6 p:�������3A` ��`����?�v�2���M`=c�u��H.��Z�b���*�� l 60\6 ~ؖ�y�T���$�Ԏ���U�V}SQQ�n�Wrg0lـ^��qgΜ!g�\�/�?�m�o��'�	Smm-���F#�NuuudK|�dz2�LdKf�����������������������_MMM�:577�@�p���ŋIӥK�h ����-Y,�t��e����V�d�Zɖ���H�������������N}�,�$�_TT���'��������_s�bd    IEND�B`�   �  0   �� H E L P . G I F         0           GIF89a  �     s�t�w�{�+|�,}�8~�J}��� ��$��.��:��<��?��-��0��7��>��C��A��C��O��R��^��D��Y��i��`��l����Ϟ�������������������������������������������������������������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           !�  � ,       � �	������\��a��T��@��D��������@r�HJ8�A	0!԰a���%
�X�sA�jx�I���HX�0F��#
� @�@,(<�*B���_4 ��+�p #��@�1���
�"$
\4�	+>2#�#?LH��� ;�  8   �� L E D - G R E E N . P N G       0           �PNG

   IHDR         VΎW   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  rIDAT8O��1n�@E��*�ž��9En�r �E��R���"Ҧs�DCW��F�������ޙ��g֌����{�����pλ�f��Mۤ��t4T��OG��V�+_��~l��}��A* (�?��X~.��?0DHzL6y�X����m�+�<.U@U��d
Q��k#U�â%)�p�q��D�u�P ��LQ,5P��� `�\�r�4�@}��q�^	��:	$� e�b�'�kW{ E��[ ŉ	�\"梨�'^|+9ݶ�\Ր��B�h���(�ԠJ���C�S���Ȓ���|(9�:�19+�Ҡ��&k<+�黣�7!�H� ��f��\���.H>u����	��3�6���T���gOW�x    IEND�B`� �  4   �� L E D - O F F . P N G       0           �PNG

   IHDR         VΎW   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  sIDAT8O�����@�� '��E�� rb"Ǆdn����@D���[���F�7����[i������H˲�u]��t:�����s�����^��8�[��a�0��n��i���y����E�u[۶�y�4a���G0�a$�r� L��k$��:FY}a} 0�	,����$��(��|�R,� `�Y@$���dV8q�} �l:��2I��IR�v({KeS!I�/����(+��)˃M02ȫ`�=3�-��@fc�,�(H׌��- ⤩�������Sy���|���df_���#?Y��^Q��#еZ��ͱP��0(ߙ%�G��>X�}���v|���+T͊-t�O���-����,�    IEND�B`��  4   �� L E D - R E D . P N G       0           �PNG

   IHDR         VΎW   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  gIDAT8O��AjAE[<@�	��x��\d�S��"� ��r�&�d��5yM93���g��^���v����)?g+��y��[.��l6��s �����]��r<�9F|am��������8?�TƯ�*3ÿc"B�^� �:�V�3U��@>��b�c�EU�*�XL�]q&�c�/�1al e��!���Q#�``X�L&5M�+ȓa�j*���˦��@@0v�F�)ֈuA���T��Hz�<5�X���,�Ύ�\l���QEt���i��S��5:�b�����+1
C�
�m�{w2)Fe�bP���o�v+�s���F�&W�G���0��Z�j��u�"�Z�/7���dLH@    IEND�B`��  <   �� L E D - Y E L L O W . P N G         0           �PNG

   IHDR         VΎW   gAMA  ���a   tEXtSoftware Paint.NET v3.10r�%�  qIDAT8O���J�@��+��������`�[��(X���M�m��D���B��P��o�s��``�dw��gg3JO۶y��HM�٭N��i���vƓTU�hȯ�P�u>?;-c���!ko�/���+�X��^廋q>9N�r�Uޙ��5��s}����1B�x-3� "��q�1`"�r����pj7��0<]o�`d��d2B?�(�b��~$Rj���EeSZ?#���*�Ō�K�&�HB� ��ƜA�* k�bt؟����QXl����d�>������侜A���]�(���]�f���k0F[Ag��/,�	�[�O1�z�ޭ�.��%�Mf�8����$�?�_��jS4 �    IEND�B`�  #  H   �� T E S T I N G - A D V A N C E D . P N G         0           �PNG

   IHDR         ��a   gAMA  ��7��   tEXtSoftware Paint.NET v3.10r�%�  �IDAT8O}�kHSa�?F���'3��Va���d����hv3�x��f�R}RӅ#�!�\�b6�ZS��ܴ͘�Dݖ��m�ܿ3�p����s~?��s|h۹\:���`6X��ml�7�͖���G���i��j�|�s[�Q%�!�0�P�{-H�!��w��"�7�Z��w��#�yy�h ��9�mGJ�oZ�0(�E|�7��P30���&ǽ����K�[��PtE���D��z�6���]����y�ܔ*��Q!ꇵ� �L�4ƣ�
׹=8v���:���!�&������4�-�`Np q%�8�^
ܳ&=���%A���⺙�3pxpοǟ�WPU~����Yq�D�8�Z�n%Y���"���}$���"8�`�U��<��P�}a0���r�)��a��6%��b��d�+`�,��b+ׁѕ��.�-ܼ��Jئ_`��TY$V��V��
��Ik����m�W��3�4������3�[M!���Ɏ����$�6F��F	����aU�¦Ά�KfeE��̢��We���Y�&�3`U&��Lh��aW��4��;M)쳯X(6�g�8�uP�P�W���ϲ���\bI|S��c���~0,�)X�y>x,��E����</�YT����eE>E�s���%Ci$�*0�(YWF�,��G#���)��ݱ����)���(�&�    IEND�B`� �  @   �� T E S T I N G - B A S I C . P N G       0           �PNG

   IHDR         ��a   gAMA  ��7��   tEXtSoftware Paint.NET v3.10r�%�  �IDAT8O}�]H�Q��.�`��͂�Ax��� �UW�F��MCb8����.�
T̘2�Ǒ�Vd�����,�c��b�b�+�s�E����9����oW�=Q����̅�s�*�����j��=�}��ْ\B���^wyn��`>u�=�r
��Zb�1E�e��-���"���ǲmX�?!ZL�����y#�����o���k�<z�	���,^~�`y3�H$��Y��&�3������톢O�v�ʵ�;;�����=�\ˠS�w���+���7NE���f�l���X^]G�|w���d�1���B!���������o(�J��� $��sss�^/���LMMݺtB�<!�b1��a��~������ �T
�Ln�KKK�Z�0�͘���\.�b�@ ���z�
����X,boo�1�3`�\F�R�����ؘsxx������V����щ���LLݐ��
�D�9T*�����W�p8���U:�
���cE���L&k��/X,�~�ǃ��]���i���_+�M��Z.�cS)��IsQ��j���F�N����$���H�&e���v��h�����,,,@�RH�,e�T�>88xB{b����h4��$���I$�"��$
���^����-
    IEND�B`�   T  @   �� T E S T I N G - N O N E . P N G         0           �PNG

   IHDR         ��a   sRGB ���   gAMA  ���a    cHRM  z&  ��  �   ��  u0  �`  :�  p��Q<   tEXtSoftware Paint.NET v3.10r�%�  �IDAT8O���+DaƧ(;�����������ec�(�Q$R��$d�,P㒅2Ðf�1c�q�ظ539g�̘���{&#cp�����<���y4�(��?>����;n�H �Oj�ږ�a[nb��WSPC�q8	>� �� ��Z�2�;v���/���p�0����c�ɗ�?��?	�c�i"�!�?Bȴ�`���r�����'�4�uQdhf��&�A�� ��]4� a&�kѢ^n�p����\�#�4ѡ�>V5��:(�	��6x���
{3��Z�^8_m��З)��bN�����<�Rcx=��tR��U'^���IfHzB��[}7��M2�A�V�*#H�b��|�G9�������5[
�{��TM���BRQx�9OmfI���;kC�4jl�cD^Cй�V�|2ŀ�2���b�P'���pގi�q�    IEND�B`��  H   �� J Q U E R Y . C Y C L E . L I T E . J S         0           /*!
 * jQuery Cycle Lite Plugin
 * http://malsup.com/jquery/cycle/lite/
 * Copyright (c) 2008-2012 M. Alsup
 * Version: 1.7 (20-FEB-2013)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * Requires: jQuery v1.3.2 or later
 */
;(function($) {
"use strict";

var ver = 'Lite-1.7';
var msie = /MSIE/.test(navigator.userAgent);

$.fn.cycle = function(options) {
    return this.each(function() {
        options = options || {};
        
        if (this.cycleTimeout) 
            clearTimeout(this.cycleTimeout);

        this.cycleTimeout = 0;
        this.cyclePause = 0;
        
        var $cont = $(this);
        var $slides = options.slideExpr ? $(options.slideExpr, this) : $cont.children();
        var els = $slides.get();
        if (els.length < 2) {
            if (window.console)
                console.log('terminating; too few slides: ' + els.length);
            return; // don't bother
        }

        // support metadata plugin (v1.0 and v2.0)
        var opts = $.extend({}, $.fn.cycle.defaults, options || {}, $.metadata ? $cont.metadata() : $.meta ? $cont.data() : {});
        var meta = $.isFunction($cont.data) ? $cont.data(opts.metaAttr) : null;
        if (meta)
            opts = $.extend(opts, meta);
            
        opts.before = opts.before ? [opts.before] : [];
        opts.after = opts.after ? [opts.after] : [];
        opts.after.unshift(function(){ opts.busy=0; });
            
        // allow shorthand overrides of width, height and timeout
        var cls = this.className;
        opts.width = parseInt((cls.match(/w:(\d+)/)||[])[1], 10) || opts.width;
        opts.height = parseInt((cls.match(/h:(\d+)/)||[])[1], 10) || opts.height;
        opts.timeout = parseInt((cls.match(/t:(\d+)/)||[])[1], 10) || opts.timeout;

        if ($cont.css('position') == 'static') 
            $cont.css('position', 'relative');
        if (opts.width) 
            $cont.width(opts.width);
        if (opts.height && opts.height != 'auto') 
            $cont.height(opts.height);

        var first = 0;
        $slides.css({position: 'absolute', top:0}).each(function(i) {
            $(this).css('z-index', els.length-i);
        });
        
        $(els[first]).css('opacity',1).show(); // opacity bit needed to handle reinit case
        if (msie) 
            els[first].style.removeAttribute('filter');

        if (opts.fit && opts.width) 
            $slides.width(opts.width);
        if (opts.fit && opts.height && opts.height != 'auto') 
            $slides.height(opts.height);
        if (opts.pause) 
            $cont.hover(function(){this.cyclePause=1;}, function(){this.cyclePause=0;});

        var txFn = $.fn.cycle.transitions[opts.fx];
        if (txFn)
            txFn($cont, $slides, opts);
        
        $slides.each(function() {
            var $el = $(this);
            this.cycleH = (opts.fit && opts.height) ? opts.height : $el.height();
            this.cycleW = (opts.fit && opts.width) ? opts.width : $el.width();
        });

        if (opts.cssFirst)
            $($slides[first]).css(opts.cssFirst);

        if (opts.timeout) {
            // ensure that timeout and speed settings are sane
            if (opts.speed.constructor == String)
                opts.speed = {slow: 600, fast: 200}[opts.speed] || 400;
            if (!opts.sync)
                opts.speed = opts.speed / 2;
            while((opts.timeout - opts.speed) < 250)
                opts.timeout += opts.speed;
        }
        opts.speedIn = opts.speed;
        opts.speedOut = opts.speed;

        opts.slideCount = els.length;
        opts.currSlide = first;
        opts.nextSlide = 1;

        // fire artificial events
        var e0 = $slides[first];
        if (opts.before.length)
            opts.before[0].apply(e0, [e0, e0, opts, true]);
        if (opts.after.length > 1)
            opts.after[1].apply(e0, [e0, e0, opts, true]);
        
        if (opts.click && !opts.next)
            opts.next = opts.click;
        if (opts.next)
            $(opts.next).unbind('click.cycle').bind('click.cycle', function(){return advance(els,opts,opts.rev?-1:1);});
        if (opts.prev)
            $(opts.prev).unbind('click.cycle').bind('click.cycle', function(){return advance(els,opts,opts.rev?1:-1);});

        if (opts.timeout)
            this.cycleTimeout = setTimeout(function() {
                go(els,opts,0,!opts.rev);
            }, opts.timeout + (opts.delay||0));
    });
};

function go(els, opts, manual, fwd) {
    if (opts.busy) 
        return;
    var p = els[0].parentNode, curr = els[opts.currSlide], next = els[opts.nextSlide];
    if (p.cycleTimeout === 0 && !manual) 
        return;

    if (manual || !p.cyclePause) {
        if (opts.before.length)
            $.each(opts.before, function(i,o) { o.apply(next, [curr, next, opts, fwd]); });
        var after = function() {
            if (msie)
                this.style.removeAttribute('filter');
            $.each(opts.after, function(i,o) { o.apply(next, [curr, next, opts, fwd]); });
            queueNext(opts);
        };

        if (opts.nextSlide != opts.currSlide) {
            opts.busy = 1;
            $.fn.cycle.custom(curr, next, opts, after);
        }
        var roll = (opts.nextSlide + 1) == els.length;
        opts.nextSlide = roll ? 0 : opts.nextSlide+1;
        opts.currSlide = roll ? els.length-1 : opts.nextSlide-1;
    } else {
      queueNext(opts);
    }

    function queueNext(opts) {
        if (opts.timeout)
            p.cycleTimeout = setTimeout(function() { go(els,opts,0,!opts.rev); }, opts.timeout);
    }
}

// advance slide forward or back
function advance(els, opts, val) {
    var p = els[0].parentNode, timeout = p.cycleTimeout;
    if (timeout) {
        clearTimeout(timeout);
        p.cycleTimeout = 0;
    }
    opts.nextSlide = opts.currSlide + val;
    if (opts.nextSlide < 0) {
        opts.nextSlide = els.length - 1;
    }
    else if (opts.nextSlide >= els.length) {
        opts.nextSlide = 0;
    }
    go(els, opts, 1, val>=0);
    return false;
}

$.fn.cycle.custom = function(curr, next, opts, cb) {
    var $l = $(curr), $n = $(next);
    $n.css(opts.cssBefore);
    var fn = function() {$n.animate(opts.animIn, opts.speedIn, opts.easeIn, cb);};
    $l.animate(opts.animOut, opts.speedOut, opts.easeOut, function() {
        $l.css(opts.cssAfter);
        if (!opts.sync)
            fn();
    });
    if (opts.sync)
        fn();
};

$.fn.cycle.transitions = {
    fade: function($cont, $slides, opts) {
        $slides.not(':eq(0)').hide();
        opts.cssBefore = { opacity: 0, display: 'block' };
        opts.cssAfter  = { display: 'none' };
        opts.animOut = { opacity: 0 };
        opts.animIn = { opacity: 1 };
    },
    fadeout: function($cont, $slides, opts) {
        opts.before.push(function(curr,next,opts,fwd) {
            $(curr).css('zIndex',opts.slideCount + (fwd === true ? 1 : 0));
            $(next).css('zIndex',opts.slideCount + (fwd === true ? 0 : 1));
        });
        $slides.not(':eq(0)').hide();
        opts.cssBefore = { opacity: 1, display: 'block', zIndex: 1 };
        opts.cssAfter  = { display: 'none', zIndex: 0 };
        opts.animOut = { opacity: 0 };
        opts.animIn = { opacity: 1 };
    }
};

$.fn.cycle.ver = function() { return ver; };

// @see: http://malsup.com/jquery/cycle/lite/
$.fn.cycle.defaults = {
    animIn:        {},
    animOut:       {},
    fx:           'fade',
    after:         null,
    before:        null,
    cssBefore:     {},
    cssAfter:      {},
    delay:         0,
    fit:           0,
    height:       'auto',
    metaAttr:     'cycle',
    next:          null,
    pause:         false,
    prev:          null,
    speed:         1000,
    slideExpr:     null,
    sync:          true,
    timeout:       4000
};

})(jQuery);  �{ H   �� J Q U E R Y - 1 . 1 2 . 4 . M I N . J S         0           /*! jQuery v1.12.4 | (c) jQuery Foundation | jquery.org/license */
!function(a,b){"object"==typeof module&&"object"==typeof module.exports?module.exports=a.document?b(a,!0):function(a){if(!a.document)throw new Error("jQuery requires a window with a document");return b(a)}:b(a)}("undefined"!=typeof window?window:this,function(a,b){var c=[],d=a.document,e=c.slice,f=c.concat,g=c.push,h=c.indexOf,i={},j=i.toString,k=i.hasOwnProperty,l={},m="1.12.4",n=function(a,b){return new n.fn.init(a,b)},o=/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g,p=/^-ms-/,q=/-([\da-z])/gi,r=function(a,b){return b.toUpperCase()};n.fn=n.prototype={jquery:m,constructor:n,selector:"",length:0,toArray:function(){return e.call(this)},get:function(a){return null!=a?0>a?this[a+this.length]:this[a]:e.call(this)},pushStack:function(a){var b=n.merge(this.constructor(),a);return b.prevObject=this,b.context=this.context,b},each:function(a){return n.each(this,a)},map:function(a){return this.pushStack(n.map(this,function(b,c){return a.call(b,c,b)}))},slice:function(){return this.pushStack(e.apply(this,arguments))},first:function(){return this.eq(0)},last:function(){return this.eq(-1)},eq:function(a){var b=this.length,c=+a+(0>a?b:0);return this.pushStack(c>=0&&b>c?[this[c]]:[])},end:function(){return this.prevObject||this.constructor()},push:g,sort:c.sort,splice:c.splice},n.extend=n.fn.extend=function(){var a,b,c,d,e,f,g=arguments[0]||{},h=1,i=arguments.length,j=!1;for("boolean"==typeof g&&(j=g,g=arguments[h]||{},h++),"object"==typeof g||n.isFunction(g)||(g={}),h===i&&(g=this,h--);i>h;h++)if(null!=(e=arguments[h]))for(d in e)a=g[d],c=e[d],g!==c&&(j&&c&&(n.isPlainObject(c)||(b=n.isArray(c)))?(b?(b=!1,f=a&&n.isArray(a)?a:[]):f=a&&n.isPlainObject(a)?a:{},g[d]=n.extend(j,f,c)):void 0!==c&&(g[d]=c));return g},n.extend({expando:"jQuery"+(m+Math.random()).replace(/\D/g,""),isReady:!0,error:function(a){throw new Error(a)},noop:function(){},isFunction:function(a){return"function"===n.type(a)},isArray:Array.isArray||function(a){return"array"===n.type(a)},isWindow:function(a){return null!=a&&a==a.window},isNumeric:function(a){var b=a&&a.toString();return!n.isArray(a)&&b-parseFloat(b)+1>=0},isEmptyObject:function(a){var b;for(b in a)return!1;return!0},isPlainObject:function(a){var b;if(!a||"object"!==n.type(a)||a.nodeType||n.isWindow(a))return!1;try{if(a.constructor&&!k.call(a,"constructor")&&!k.call(a.constructor.prototype,"isPrototypeOf"))return!1}catch(c){return!1}if(!l.ownFirst)for(b in a)return k.call(a,b);for(b in a);return void 0===b||k.call(a,b)},type:function(a){return null==a?a+"":"object"==typeof a||"function"==typeof a?i[j.call(a)]||"object":typeof a},globalEval:function(b){b&&n.trim(b)&&(a.execScript||function(b){a.eval.call(a,b)})(b)},camelCase:function(a){return a.replace(p,"ms-").replace(q,r)},nodeName:function(a,b){return a.nodeName&&a.nodeName.toLowerCase()===b.toLowerCase()},each:function(a,b){var c,d=0;if(s(a)){for(c=a.length;c>d;d++)if(b.call(a[d],d,a[d])===!1)break}else for(d in a)if(b.call(a[d],d,a[d])===!1)break;return a},trim:function(a){return null==a?"":(a+"").replace(o,"")},makeArray:function(a,b){var c=b||[];return null!=a&&(s(Object(a))?n.merge(c,"string"==typeof a?[a]:a):g.call(c,a)),c},inArray:function(a,b,c){var d;if(b){if(h)return h.call(b,a,c);for(d=b.length,c=c?0>c?Math.max(0,d+c):c:0;d>c;c++)if(c in b&&b[c]===a)return c}return-1},merge:function(a,b){var c=+b.length,d=0,e=a.length;while(c>d)a[e++]=b[d++];if(c!==c)while(void 0!==b[d])a[e++]=b[d++];return a.length=e,a},grep:function(a,b,c){for(var d,e=[],f=0,g=a.length,h=!c;g>f;f++)d=!b(a[f],f),d!==h&&e.push(a[f]);return e},map:function(a,b,c){var d,e,g=0,h=[];if(s(a))for(d=a.length;d>g;g++)e=b(a[g],g,c),null!=e&&h.push(e);else for(g in a)e=b(a[g],g,c),null!=e&&h.push(e);return f.apply([],h)},guid:1,proxy:function(a,b){var c,d,f;return"string"==typeof b&&(f=a[b],b=a,a=f),n.isFunction(a)?(c=e.call(arguments,2),d=function(){return a.apply(b||this,c.concat(e.call(arguments)))},d.guid=a.guid=a.guid||n.guid++,d):void 0},now:function(){return+new Date},support:l}),"function"==typeof Symbol&&(n.fn[Symbol.iterator]=c[Symbol.iterator]),n.each("Boolean Number String Function Array Date RegExp Object Error Symbol".split(" "),function(a,b){i["[object "+b+"]"]=b.toLowerCase()});function s(a){var b=!!a&&"length"in a&&a.length,c=n.type(a);return"function"===c||n.isWindow(a)?!1:"array"===c||0===b||"number"==typeof b&&b>0&&b-1 in a}var t=function(a){var b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u="sizzle"+1*new Date,v=a.document,w=0,x=0,y=ga(),z=ga(),A=ga(),B=function(a,b){return a===b&&(l=!0),0},C=1<<31,D={}.hasOwnProperty,E=[],F=E.pop,G=E.push,H=E.push,I=E.slice,J=function(a,b){for(var c=0,d=a.length;d>c;c++)if(a[c]===b)return c;return-1},K="checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped",L="[\\x20\\t\\r\\n\\f]",M="(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+",N="\\["+L+"*("+M+")(?:"+L+"*([*^$|!~]?=)"+L+"*(?:'((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\"|("+M+"))|)"+L+"*\\]",O=":("+M+")(?:\\((('((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\")|((?:\\\\.|[^\\\\()[\\]]|"+N+")*)|.*)\\)|)",P=new RegExp(L+"+","g"),Q=new RegExp("^"+L+"+|((?:^|[^\\\\])(?:\\\\.)*)"+L+"+$","g"),R=new RegExp("^"+L+"*,"+L+"*"),S=new RegExp("^"+L+"*([>+~]|"+L+")"+L+"*"),T=new RegExp("="+L+"*([^\\]'\"]*?)"+L+"*\\]","g"),U=new RegExp(O),V=new RegExp("^"+M+"$"),W={ID:new RegExp("^#("+M+")"),CLASS:new RegExp("^\\.("+M+")"),TAG:new RegExp("^("+M+"|[*])"),ATTR:new RegExp("^"+N),PSEUDO:new RegExp("^"+O),CHILD:new RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\("+L+"*(even|odd|(([+-]|)(\\d*)n|)"+L+"*(?:([+-]|)"+L+"*(\\d+)|))"+L+"*\\)|)","i"),bool:new RegExp("^(?:"+K+")$","i"),needsContext:new RegExp("^"+L+"*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\("+L+"*((?:-\\d)?\\d*)"+L+"*\\)|)(?=[^-]|$)","i")},X=/^(?:input|select|textarea|button)$/i,Y=/^h\d$/i,Z=/^[^{]+\{\s*\[native \w/,$=/^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/,_=/[+~]/,aa=/'|\\/g,ba=new RegExp("\\\\([\\da-f]{1,6}"+L+"?|("+L+")|.)","ig"),ca=function(a,b,c){var d="0x"+b-65536;return d!==d||c?b:0>d?String.fromCharCode(d+65536):String.fromCharCode(d>>10|55296,1023&d|56320)},da=function(){m()};try{H.apply(E=I.call(v.childNodes),v.childNodes),E[v.childNodes.length].nodeType}catch(ea){H={apply:E.length?function(a,b){G.apply(a,I.call(b))}:function(a,b){var c=a.length,d=0;while(a[c++]=b[d++]);a.length=c-1}}}function fa(a,b,d,e){var f,h,j,k,l,o,r,s,w=b&&b.ownerDocument,x=b?b.nodeType:9;if(d=d||[],"string"!=typeof a||!a||1!==x&&9!==x&&11!==x)return d;if(!e&&((b?b.ownerDocument||b:v)!==n&&m(b),b=b||n,p)){if(11!==x&&(o=$.exec(a)))if(f=o[1]){if(9===x){if(!(j=b.getElementById(f)))return d;if(j.id===f)return d.push(j),d}else if(w&&(j=w.getElementById(f))&&t(b,j)&&j.id===f)return d.push(j),d}else{if(o[2])return H.apply(d,b.getElementsByTagName(a)),d;if((f=o[3])&&c.getElementsByClassName&&b.getElementsByClassName)return H.apply(d,b.getElementsByClassName(f)),d}if(c.qsa&&!A[a+" "]&&(!q||!q.test(a))){if(1!==x)w=b,s=a;else if("object"!==b.nodeName.toLowerCase()){(k=b.getAttribute("id"))?k=k.replace(aa,"\\$&"):b.setAttribute("id",k=u),r=g(a),h=r.length,l=V.test(k)?"#"+k:"[id='"+k+"']";while(h--)r[h]=l+" "+qa(r[h]);s=r.join(","),w=_.test(a)&&oa(b.parentNode)||b}if(s)try{return H.apply(d,w.querySelectorAll(s)),d}catch(y){}finally{k===u&&b.removeAttribute("id")}}}return i(a.replace(Q,"$1"),b,d,e)}function ga(){var a=[];function b(c,e){return a.push(c+" ")>d.cacheLength&&delete b[a.shift()],b[c+" "]=e}return b}function ha(a){return a[u]=!0,a}function ia(a){var b=n.createElement("div");try{return!!a(b)}catch(c){return!1}finally{b.parentNode&&b.parentNode.removeChild(b),b=null}}function ja(a,b){var c=a.split("|"),e=c.length;while(e--)d.attrHandle[c[e]]=b}function ka(a,b){var c=b&&a,d=c&&1===a.nodeType&&1===b.nodeType&&(~b.sourceIndex||C)-(~a.sourceIndex||C);if(d)return d;if(c)while(c=c.nextSibling)if(c===b)return-1;return a?1:-1}function la(a){return function(b){var c=b.nodeName.toLowerCase();return"input"===c&&b.type===a}}function ma(a){return function(b){var c=b.nodeName.toLowerCase();return("input"===c||"button"===c)&&b.type===a}}function na(a){return ha(function(b){return b=+b,ha(function(c,d){var e,f=a([],c.length,b),g=f.length;while(g--)c[e=f[g]]&&(c[e]=!(d[e]=c[e]))})})}function oa(a){return a&&"undefined"!=typeof a.getElementsByTagName&&a}c=fa.support={},f=fa.isXML=function(a){var b=a&&(a.ownerDocument||a).documentElement;return b?"HTML"!==b.nodeName:!1},m=fa.setDocument=function(a){var b,e,g=a?a.ownerDocument||a:v;return g!==n&&9===g.nodeType&&g.documentElement?(n=g,o=n.documentElement,p=!f(n),(e=n.defaultView)&&e.top!==e&&(e.addEventListener?e.addEventListener("unload",da,!1):e.attachEvent&&e.attachEvent("onunload",da)),c.attributes=ia(function(a){return a.className="i",!a.getAttribute("className")}),c.getElementsByTagName=ia(function(a){return a.appendChild(n.createComment("")),!a.getElementsByTagName("*").length}),c.getElementsByClassName=Z.test(n.getElementsByClassName),c.getById=ia(function(a){return o.appendChild(a).id=u,!n.getElementsByName||!n.getElementsByName(u).length}),c.getById?(d.find.ID=function(a,b){if("undefined"!=typeof b.getElementById&&p){var c=b.getElementById(a);return c?[c]:[]}},d.filter.ID=function(a){var b=a.replace(ba,ca);return function(a){return a.getAttribute("id")===b}}):(delete d.find.ID,d.filter.ID=function(a){var b=a.replace(ba,ca);return function(a){var c="undefined"!=typeof a.getAttributeNode&&a.getAttributeNode("id");return c&&c.value===b}}),d.find.TAG=c.getElementsByTagName?function(a,b){return"undefined"!=typeof b.getElementsByTagName?b.getElementsByTagName(a):c.qsa?b.querySelectorAll(a):void 0}:function(a,b){var c,d=[],e=0,f=b.getElementsByTagName(a);if("*"===a){while(c=f[e++])1===c.nodeType&&d.push(c);return d}return f},d.find.CLASS=c.getElementsByClassName&&function(a,b){return"undefined"!=typeof b.getElementsByClassName&&p?b.getElementsByClassName(a):void 0},r=[],q=[],(c.qsa=Z.test(n.querySelectorAll))&&(ia(function(a){o.appendChild(a).innerHTML="<a id='"+u+"'></a><select id='"+u+"-\r\\' msallowcapture=''><option selected=''></option></select>",a.querySelectorAll("[msallowcapture^='']").length&&q.push("[*^$]="+L+"*(?:''|\"\")"),a.querySelectorAll("[selected]").length||q.push("\\["+L+"*(?:value|"+K+")"),a.querySelectorAll("[id~="+u+"-]").length||q.push("~="),a.querySelectorAll(":checked").length||q.push(":checked"),a.querySelectorAll("a#"+u+"+*").length||q.push(".#.+[+~]")}),ia(function(a){var b=n.createElement("input");b.setAttribute("type","hidden"),a.appendChild(b).setAttribute("name","D"),a.querySelectorAll("[name=d]").length&&q.push("name"+L+"*[*^$|!~]?="),a.querySelectorAll(":enabled").length||q.push(":enabled",":disabled"),a.querySelectorAll("*,:x"),q.push(",.*:")})),(c.matchesSelector=Z.test(s=o.matches||o.webkitMatchesSelector||o.mozMatchesSelector||o.oMatchesSelector||o.msMatchesSelector))&&ia(function(a){c.disconnectedMatch=s.call(a,"div"),s.call(a,"[s!='']:x"),r.push("!=",O)}),q=q.length&&new RegExp(q.join("|")),r=r.length&&new RegExp(r.join("|")),b=Z.test(o.compareDocumentPosition),t=b||Z.test(o.contains)?function(a,b){var c=9===a.nodeType?a.documentElement:a,d=b&&b.parentNode;return a===d||!(!d||1!==d.nodeType||!(c.contains?c.contains(d):a.compareDocumentPosition&&16&a.compareDocumentPosition(d)))}:function(a,b){if(b)while(b=b.parentNode)if(b===a)return!0;return!1},B=b?function(a,b){if(a===b)return l=!0,0;var d=!a.compareDocumentPosition-!b.compareDocumentPosition;return d?d:(d=(a.ownerDocument||a)===(b.ownerDocument||b)?a.compareDocumentPosition(b):1,1&d||!c.sortDetached&&b.compareDocumentPosition(a)===d?a===n||a.ownerDocument===v&&t(v,a)?-1:b===n||b.ownerDocument===v&&t(v,b)?1:k?J(k,a)-J(k,b):0:4&d?-1:1)}:function(a,b){if(a===b)return l=!0,0;var c,d=0,e=a.parentNode,f=b.parentNode,g=[a],h=[b];if(!e||!f)return a===n?-1:b===n?1:e?-1:f?1:k?J(k,a)-J(k,b):0;if(e===f)return ka(a,b);c=a;while(c=c.parentNode)g.unshift(c);c=b;while(c=c.parentNode)h.unshift(c);while(g[d]===h[d])d++;return d?ka(g[d],h[d]):g[d]===v?-1:h[d]===v?1:0},n):n},fa.matches=function(a,b){return fa(a,null,null,b)},fa.matchesSelector=function(a,b){if((a.ownerDocument||a)!==n&&m(a),b=b.replace(T,"='$1']"),c.matchesSelector&&p&&!A[b+" "]&&(!r||!r.test(b))&&(!q||!q.test(b)))try{var d=s.call(a,b);if(d||c.disconnectedMatch||a.document&&11!==a.document.nodeType)return d}catch(e){}return fa(b,n,null,[a]).length>0},fa.contains=function(a,b){return(a.ownerDocument||a)!==n&&m(a),t(a,b)},fa.attr=function(a,b){(a.ownerDocument||a)!==n&&m(a);var e=d.attrHandle[b.toLowerCase()],f=e&&D.call(d.attrHandle,b.toLowerCase())?e(a,b,!p):void 0;return void 0!==f?f:c.attributes||!p?a.getAttribute(b):(f=a.getAttributeNode(b))&&f.specified?f.value:null},fa.error=function(a){throw new Error("Syntax error, unrecognized expression: "+a)},fa.uniqueSort=function(a){var b,d=[],e=0,f=0;if(l=!c.detectDuplicates,k=!c.sortStable&&a.slice(0),a.sort(B),l){while(b=a[f++])b===a[f]&&(e=d.push(f));while(e--)a.splice(d[e],1)}return k=null,a},e=fa.getText=function(a){var b,c="",d=0,f=a.nodeType;if(f){if(1===f||9===f||11===f){if("string"==typeof a.textContent)return a.textContent;for(a=a.firstChild;a;a=a.nextSibling)c+=e(a)}else if(3===f||4===f)return a.nodeValue}else while(b=a[d++])c+=e(b);return c},d=fa.selectors={cacheLength:50,createPseudo:ha,match:W,attrHandle:{},find:{},relative:{">":{dir:"parentNode",first:!0}," ":{dir:"parentNode"},"+":{dir:"previousSibling",first:!0},"~":{dir:"previousSibling"}},preFilter:{ATTR:function(a){return a[1]=a[1].replace(ba,ca),a[3]=(a[3]||a[4]||a[5]||"").replace(ba,ca),"~="===a[2]&&(a[3]=" "+a[3]+" "),a.slice(0,4)},CHILD:function(a){return a[1]=a[1].toLowerCase(),"nth"===a[1].slice(0,3)?(a[3]||fa.error(a[0]),a[4]=+(a[4]?a[5]+(a[6]||1):2*("even"===a[3]||"odd"===a[3])),a[5]=+(a[7]+a[8]||"odd"===a[3])):a[3]&&fa.error(a[0]),a},PSEUDO:function(a){var b,c=!a[6]&&a[2];return W.CHILD.test(a[0])?null:(a[3]?a[2]=a[4]||a[5]||"":c&&U.test(c)&&(b=g(c,!0))&&(b=c.indexOf(")",c.length-b)-c.length)&&(a[0]=a[0].slice(0,b),a[2]=c.slice(0,b)),a.slice(0,3))}},filter:{TAG:function(a){var b=a.replace(ba,ca).toLowerCase();return"*"===a?function(){return!0}:function(a){return a.nodeName&&a.nodeName.toLowerCase()===b}},CLASS:function(a){var b=y[a+" "];return b||(b=new RegExp("(^|"+L+")"+a+"("+L+"|$)"))&&y(a,function(a){return b.test("string"==typeof a.className&&a.className||"undefined"!=typeof a.getAttribute&&a.getAttribute("class")||"")})},ATTR:function(a,b,c){return function(d){var e=fa.attr(d,a);return null==e?"!="===b:b?(e+="","="===b?e===c:"!="===b?e!==c:"^="===b?c&&0===e.indexOf(c):"*="===b?c&&e.indexOf(c)>-1:"$="===b?c&&e.slice(-c.length)===c:"~="===b?(" "+e.replace(P," ")+" ").indexOf(c)>-1:"|="===b?e===c||e.slice(0,c.length+1)===c+"-":!1):!0}},CHILD:function(a,b,c,d,e){var f="nth"!==a.slice(0,3),g="last"!==a.slice(-4),h="of-type"===b;return 1===d&&0===e?function(a){return!!a.parentNode}:function(b,c,i){var j,k,l,m,n,o,p=f!==g?"nextSibling":"previousSibling",q=b.parentNode,r=h&&b.nodeName.toLowerCase(),s=!i&&!h,t=!1;if(q){if(f){while(p){m=b;while(m=m[p])if(h?m.nodeName.toLowerCase()===r:1===m.nodeType)return!1;o=p="only"===a&&!o&&"nextSibling"}return!0}if(o=[g?q.firstChild:q.lastChild],g&&s){m=q,l=m[u]||(m[u]={}),k=l[m.uniqueID]||(l[m.uniqueID]={}),j=k[a]||[],n=j[0]===w&&j[1],t=n&&j[2],m=n&&q.childNodes[n];while(m=++n&&m&&m[p]||(t=n=0)||o.pop())if(1===m.nodeType&&++t&&m===b){k[a]=[w,n,t];break}}else if(s&&(m=b,l=m[u]||(m[u]={}),k=l[m.uniqueID]||(l[m.uniqueID]={}),j=k[a]||[],n=j[0]===w&&j[1],t=n),t===!1)while(m=++n&&m&&m[p]||(t=n=0)||o.pop())if((h?m.nodeName.toLowerCase()===r:1===m.nodeType)&&++t&&(s&&(l=m[u]||(m[u]={}),k=l[m.uniqueID]||(l[m.uniqueID]={}),k[a]=[w,t]),m===b))break;return t-=e,t===d||t%d===0&&t/d>=0}}},PSEUDO:function(a,b){var c,e=d.pseudos[a]||d.setFilters[a.toLowerCase()]||fa.error("unsupported pseudo: "+a);return e[u]?e(b):e.length>1?(c=[a,a,"",b],d.setFilters.hasOwnProperty(a.toLowerCase())?ha(function(a,c){var d,f=e(a,b),g=f.length;while(g--)d=J(a,f[g]),a[d]=!(c[d]=f[g])}):function(a){return e(a,0,c)}):e}},pseudos:{not:ha(function(a){var b=[],c=[],d=h(a.replace(Q,"$1"));return d[u]?ha(function(a,b,c,e){var f,g=d(a,null,e,[]),h=a.length;while(h--)(f=g[h])&&(a[h]=!(b[h]=f))}):function(a,e,f){return b[0]=a,d(b,null,f,c),b[0]=null,!c.pop()}}),has:ha(function(a){return function(b){return fa(a,b).length>0}}),contains:ha(function(a){return a=a.replace(ba,ca),function(b){return(b.textContent||b.innerText||e(b)).indexOf(a)>-1}}),lang:ha(function(a){return V.test(a||"")||fa.error("unsupported lang: "+a),a=a.replace(ba,ca).toLowerCase(),function(b){var c;do if(c=p?b.lang:b.getAttribute("xml:lang")||b.getAttribute("lang"))return c=c.toLowerCase(),c===a||0===c.indexOf(a+"-");while((b=b.parentNode)&&1===b.nodeType);return!1}}),target:function(b){var c=a.location&&a.location.hash;return c&&c.slice(1)===b.id},root:function(a){return a===o},focus:function(a){return a===n.activeElement&&(!n.hasFocus||n.hasFocus())&&!!(a.type||a.href||~a.tabIndex)},enabled:function(a){return a.disabled===!1},disabled:function(a){return a.disabled===!0},checked:function(a){var b=a.nodeName.toLowerCase();return"input"===b&&!!a.checked||"option"===b&&!!a.selected},selected:function(a){return a.parentNode&&a.parentNode.selectedIndex,a.selected===!0},empty:function(a){for(a=a.firstChild;a;a=a.nextSibling)if(a.nodeType<6)return!1;return!0},parent:function(a){return!d.pseudos.empty(a)},header:function(a){return Y.test(a.nodeName)},input:function(a){return X.test(a.nodeName)},button:function(a){var b=a.nodeName.toLowerCase();return"input"===b&&"button"===a.type||"button"===b},text:function(a){var b;return"input"===a.nodeName.toLowerCase()&&"text"===a.type&&(null==(b=a.getAttribute("type"))||"text"===b.toLowerCase())},first:na(function(){return[0]}),last:na(function(a,b){return[b-1]}),eq:na(function(a,b,c){return[0>c?c+b:c]}),even:na(function(a,b){for(var c=0;b>c;c+=2)a.push(c);return a}),odd:na(function(a,b){for(var c=1;b>c;c+=2)a.push(c);return a}),lt:na(function(a,b,c){for(var d=0>c?c+b:c;--d>=0;)a.push(d);return a}),gt:na(function(a,b,c){for(var d=0>c?c+b:c;++d<b;)a.push(d);return a})}},d.pseudos.nth=d.pseudos.eq;for(b in{radio:!0,checkbox:!0,file:!0,password:!0,image:!0})d.pseudos[b]=la(b);for(b in{submit:!0,reset:!0})d.pseudos[b]=ma(b);function pa(){}pa.prototype=d.filters=d.pseudos,d.setFilters=new pa,g=fa.tokenize=function(a,b){var c,e,f,g,h,i,j,k=z[a+" "];if(k)return b?0:k.slice(0);h=a,i=[],j=d.preFilter;while(h){c&&!(e=R.exec(h))||(e&&(h=h.slice(e[0].length)||h),i.push(f=[])),c=!1,(e=S.exec(h))&&(c=e.shift(),f.push({value:c,type:e[0].replace(Q," ")}),h=h.slice(c.length));for(g in d.filter)!(e=W[g].exec(h))||j[g]&&!(e=j[g](e))||(c=e.shift(),f.push({value:c,type:g,matches:e}),h=h.slice(c.length));if(!c)break}return b?h.length:h?fa.error(a):z(a,i).slice(0)};function qa(a){for(var b=0,c=a.length,d="";c>b;b++)d+=a[b].value;return d}function ra(a,b,c){var d=b.dir,e=c&&"parentNode"===d,f=x++;return b.first?function(b,c,f){while(b=b[d])if(1===b.nodeType||e)return a(b,c,f)}:function(b,c,g){var h,i,j,k=[w,f];if(g){while(b=b[d])if((1===b.nodeType||e)&&a(b,c,g))return!0}else while(b=b[d])if(1===b.nodeType||e){if(j=b[u]||(b[u]={}),i=j[b.uniqueID]||(j[b.uniqueID]={}),(h=i[d])&&h[0]===w&&h[1]===f)return k[2]=h[2];if(i[d]=k,k[2]=a(b,c,g))return!0}}}function sa(a){return a.length>1?function(b,c,d){var e=a.length;while(e--)if(!a[e](b,c,d))return!1;return!0}:a[0]}function ta(a,b,c){for(var d=0,e=b.length;e>d;d++)fa(a,b[d],c);return c}function ua(a,b,c,d,e){for(var f,g=[],h=0,i=a.length,j=null!=b;i>h;h++)(f=a[h])&&(c&&!c(f,d,e)||(g.push(f),j&&b.push(h)));return g}function va(a,b,c,d,e,f){return d&&!d[u]&&(d=va(d)),e&&!e[u]&&(e=va(e,f)),ha(function(f,g,h,i){var j,k,l,m=[],n=[],o=g.length,p=f||ta(b||"*",h.nodeType?[h]:h,[]),q=!a||!f&&b?p:ua(p,m,a,h,i),r=c?e||(f?a:o||d)?[]:g:q;if(c&&c(q,r,h,i),d){j=ua(r,n),d(j,[],h,i),k=j.length;while(k--)(l=j[k])&&(r[n[k]]=!(q[n[k]]=l))}if(f){if(e||a){if(e){j=[],k=r.length;while(k--)(l=r[k])&&j.push(q[k]=l);e(null,r=[],j,i)}k=r.length;while(k--)(l=r[k])&&(j=e?J(f,l):m[k])>-1&&(f[j]=!(g[j]=l))}}else r=ua(r===g?r.splice(o,r.length):r),e?e(null,g,r,i):H.apply(g,r)})}function wa(a){for(var b,c,e,f=a.length,g=d.relative[a[0].type],h=g||d.relative[" "],i=g?1:0,k=ra(function(a){return a===b},h,!0),l=ra(function(a){return J(b,a)>-1},h,!0),m=[function(a,c,d){var e=!g&&(d||c!==j)||((b=c).nodeType?k(a,c,d):l(a,c,d));return b=null,e}];f>i;i++)if(c=d.relative[a[i].type])m=[ra(sa(m),c)];else{if(c=d.filter[a[i].type].apply(null,a[i].matches),c[u]){for(e=++i;f>e;e++)if(d.relative[a[e].type])break;return va(i>1&&sa(m),i>1&&qa(a.slice(0,i-1).concat({value:" "===a[i-2].type?"*":""})).replace(Q,"$1"),c,e>i&&wa(a.slice(i,e)),f>e&&wa(a=a.slice(e)),f>e&&qa(a))}m.push(c)}return sa(m)}function xa(a,b){var c=b.length>0,e=a.length>0,f=function(f,g,h,i,k){var l,o,q,r=0,s="0",t=f&&[],u=[],v=j,x=f||e&&d.find.TAG("*",k),y=w+=null==v?1:Math.random()||.1,z=x.length;for(k&&(j=g===n||g||k);s!==z&&null!=(l=x[s]);s++){if(e&&l){o=0,g||l.ownerDocument===n||(m(l),h=!p);while(q=a[o++])if(q(l,g||n,h)){i.push(l);break}k&&(w=y)}c&&((l=!q&&l)&&r--,f&&t.push(l))}if(r+=s,c&&s!==r){o=0;while(q=b[o++])q(t,u,g,h);if(f){if(r>0)while(s--)t[s]||u[s]||(u[s]=F.call(i));u=ua(u)}H.apply(i,u),k&&!f&&u.length>0&&r+b.length>1&&fa.uniqueSort(i)}return k&&(w=y,j=v),t};return c?ha(f):f}return h=fa.compile=function(a,b){var c,d=[],e=[],f=A[a+" "];if(!f){b||(b=g(a)),c=b.length;while(c--)f=wa(b[c]),f[u]?d.push(f):e.push(f);f=A(a,xa(e,d)),f.selector=a}return f},i=fa.select=function(a,b,e,f){var i,j,k,l,m,n="function"==typeof a&&a,o=!f&&g(a=n.selector||a);if(e=e||[],1===o.length){if(j=o[0]=o[0].slice(0),j.length>2&&"ID"===(k=j[0]).type&&c.getById&&9===b.nodeType&&p&&d.relative[j[1].type]){if(b=(d.find.ID(k.matches[0].replace(ba,ca),b)||[])[0],!b)return e;n&&(b=b.parentNode),a=a.slice(j.shift().value.length)}i=W.needsContext.test(a)?0:j.length;while(i--){if(k=j[i],d.relative[l=k.type])break;if((m=d.find[l])&&(f=m(k.matches[0].replace(ba,ca),_.test(j[0].type)&&oa(b.parentNode)||b))){if(j.splice(i,1),a=f.length&&qa(j),!a)return H.apply(e,f),e;break}}}return(n||h(a,o))(f,b,!p,e,!b||_.test(a)&&oa(b.parentNode)||b),e},c.sortStable=u.split("").sort(B).join("")===u,c.detectDuplicates=!!l,m(),c.sortDetached=ia(function(a){return 1&a.compareDocumentPosition(n.createElement("div"))}),ia(function(a){return a.innerHTML="<a href='#'></a>","#"===a.firstChild.getAttribute("href")})||ja("type|href|height|width",function(a,b,c){return c?void 0:a.getAttribute(b,"type"===b.toLowerCase()?1:2)}),c.attributes&&ia(function(a){return a.innerHTML="<input/>",a.firstChild.setAttribute("value",""),""===a.firstChild.getAttribute("value")})||ja("value",function(a,b,c){return c||"input"!==a.nodeName.toLowerCase()?void 0:a.defaultValue}),ia(function(a){return null==a.getAttribute("disabled")})||ja(K,function(a,b,c){var d;return c?void 0:a[b]===!0?b.toLowerCase():(d=a.getAttributeNode(b))&&d.specified?d.value:null}),fa}(a);n.find=t,n.expr=t.selectors,n.expr[":"]=n.expr.pseudos,n.uniqueSort=n.unique=t.uniqueSort,n.text=t.getText,n.isXMLDoc=t.isXML,n.contains=t.contains;var u=function(a,b,c){var d=[],e=void 0!==c;while((a=a[b])&&9!==a.nodeType)if(1===a.nodeType){if(e&&n(a).is(c))break;d.push(a)}return d},v=function(a,b){for(var c=[];a;a=a.nextSibling)1===a.nodeType&&a!==b&&c.push(a);return c},w=n.expr.match.needsContext,x=/^<([\w-]+)\s*\/?>(?:<\/\1>|)$/,y=/^.[^:#\[\.,]*$/;function z(a,b,c){if(n.isFunction(b))return n.grep(a,function(a,d){return!!b.call(a,d,a)!==c});if(b.nodeType)return n.grep(a,function(a){return a===b!==c});if("string"==typeof b){if(y.test(b))return n.filter(b,a,c);b=n.filter(b,a)}return n.grep(a,function(a){return n.inArray(a,b)>-1!==c})}n.filter=function(a,b,c){var d=b[0];return c&&(a=":not("+a+")"),1===b.length&&1===d.nodeType?n.find.matchesSelector(d,a)?[d]:[]:n.find.matches(a,n.grep(b,function(a){return 1===a.nodeType}))},n.fn.extend({find:function(a){var b,c=[],d=this,e=d.length;if("string"!=typeof a)return this.pushStack(n(a).filter(function(){for(b=0;e>b;b++)if(n.contains(d[b],this))return!0}));for(b=0;e>b;b++)n.find(a,d[b],c);return c=this.pushStack(e>1?n.unique(c):c),c.selector=this.selector?this.selector+" "+a:a,c},filter:function(a){return this.pushStack(z(this,a||[],!1))},not:function(a){return this.pushStack(z(this,a||[],!0))},is:function(a){return!!z(this,"string"==typeof a&&w.test(a)?n(a):a||[],!1).length}});var A,B=/^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/,C=n.fn.init=function(a,b,c){var e,f;if(!a)return this;if(c=c||A,"string"==typeof a){if(e="<"===a.charAt(0)&&">"===a.charAt(a.length-1)&&a.length>=3?[null,a,null]:B.exec(a),!e||!e[1]&&b)return!b||b.jquery?(b||c).find(a):this.constructor(b).find(a);if(e[1]){if(b=b instanceof n?b[0]:b,n.merge(this,n.parseHTML(e[1],b&&b.nodeType?b.ownerDocument||b:d,!0)),x.test(e[1])&&n.isPlainObject(b))for(e in b)n.isFunction(this[e])?this[e](b[e]):this.attr(e,b[e]);return this}if(f=d.getElementById(e[2]),f&&f.parentNode){if(f.id!==e[2])return A.find(a);this.length=1,this[0]=f}return this.context=d,this.selector=a,this}return a.nodeType?(this.context=this[0]=a,this.length=1,this):n.isFunction(a)?"undefined"!=typeof c.ready?c.ready(a):a(n):(void 0!==a.selector&&(this.selector=a.selector,this.context=a.context),n.makeArray(a,this))};C.prototype=n.fn,A=n(d);var D=/^(?:parents|prev(?:Until|All))/,E={children:!0,contents:!0,next:!0,prev:!0};n.fn.extend({has:function(a){var b,c=n(a,this),d=c.length;return this.filter(function(){for(b=0;d>b;b++)if(n.contains(this,c[b]))return!0})},closest:function(a,b){for(var c,d=0,e=this.length,f=[],g=w.test(a)||"string"!=typeof a?n(a,b||this.context):0;e>d;d++)for(c=this[d];c&&c!==b;c=c.parentNode)if(c.nodeType<11&&(g?g.index(c)>-1:1===c.nodeType&&n.find.matchesSelector(c,a))){f.push(c);break}return this.pushStack(f.length>1?n.uniqueSort(f):f)},index:function(a){return a?"string"==typeof a?n.inArray(this[0],n(a)):n.inArray(a.jquery?a[0]:a,this):this[0]&&this[0].parentNode?this.first().prevAll().length:-1},add:function(a,b){return this.pushStack(n.uniqueSort(n.merge(this.get(),n(a,b))))},addBack:function(a){return this.add(null==a?this.prevObject:this.prevObject.filter(a))}});function F(a,b){do a=a[b];while(a&&1!==a.nodeType);return a}n.each({parent:function(a){var b=a.parentNode;return b&&11!==b.nodeType?b:null},parents:function(a){return u(a,"parentNode")},parentsUntil:function(a,b,c){return u(a,"parentNode",c)},next:function(a){return F(a,"nextSibling")},prev:function(a){return F(a,"previousSibling")},nextAll:function(a){return u(a,"nextSibling")},prevAll:function(a){return u(a,"previousSibling")},nextUntil:function(a,b,c){return u(a,"nextSibling",c)},prevUntil:function(a,b,c){return u(a,"previousSibling",c)},siblings:function(a){return v((a.parentNode||{}).firstChild,a)},children:function(a){return v(a.firstChild)},contents:function(a){return n.nodeName(a,"iframe")?a.contentDocument||a.contentWindow.document:n.merge([],a.childNodes)}},function(a,b){n.fn[a]=function(c,d){var e=n.map(this,b,c);return"Until"!==a.slice(-5)&&(d=c),d&&"string"==typeof d&&(e=n.filter(d,e)),this.length>1&&(E[a]||(e=n.uniqueSort(e)),D.test(a)&&(e=e.reverse())),this.pushStack(e)}});var G=/\S+/g;function H(a){var b={};return n.each(a.match(G)||[],function(a,c){b[c]=!0}),b}n.Callbacks=function(a){a="string"==typeof a?H(a):n.extend({},a);var b,c,d,e,f=[],g=[],h=-1,i=function(){for(e=a.once,d=b=!0;g.length;h=-1){c=g.shift();while(++h<f.length)f[h].apply(c[0],c[1])===!1&&a.stopOnFalse&&(h=f.length,c=!1)}a.memory||(c=!1),b=!1,e&&(f=c?[]:"")},j={add:function(){return f&&(c&&!b&&(h=f.length-1,g.push(c)),function d(b){n.each(b,function(b,c){n.isFunction(c)?a.unique&&j.has(c)||f.push(c):c&&c.length&&"string"!==n.type(c)&&d(c)})}(arguments),c&&!b&&i()),this},remove:function(){return n.each(arguments,function(a,b){var c;while((c=n.inArray(b,f,c))>-1)f.splice(c,1),h>=c&&h--}),this},has:function(a){return a?n.inArray(a,f)>-1:f.length>0},empty:function(){return f&&(f=[]),this},disable:function(){return e=g=[],f=c="",this},disabled:function(){return!f},lock:function(){return e=!0,c||j.disable(),this},locked:function(){return!!e},fireWith:function(a,c){return e||(c=c||[],c=[a,c.slice?c.slice():c],g.push(c),b||i()),this},fire:function(){return j.fireWith(this,arguments),this},fired:function(){return!!d}};return j},n.extend({Deferred:function(a){var b=[["resolve","done",n.Callbacks("once memory"),"resolved"],["reject","fail",n.Callbacks("once memory"),"rejected"],["notify","progress",n.Callbacks("memory")]],c="pending",d={state:function(){return c},always:function(){return e.done(arguments).fail(arguments),this},then:function(){var a=arguments;return n.Deferred(function(c){n.each(b,function(b,f){var g=n.isFunction(a[b])&&a[b];e[f[1]](function(){var a=g&&g.apply(this,arguments);a&&n.isFunction(a.promise)?a.promise().progress(c.notify).done(c.resolve).fail(c.reject):c[f[0]+"With"](this===d?c.promise():this,g?[a]:arguments)})}),a=null}).promise()},promise:function(a){return null!=a?n.extend(a,d):d}},e={};return d.pipe=d.then,n.each(b,function(a,f){var g=f[2],h=f[3];d[f[1]]=g.add,h&&g.add(function(){c=h},b[1^a][2].disable,b[2][2].lock),e[f[0]]=function(){return e[f[0]+"With"](this===e?d:this,arguments),this},e[f[0]+"With"]=g.fireWith}),d.promise(e),a&&a.call(e,e),e},when:function(a){var b=0,c=e.call(arguments),d=c.length,f=1!==d||a&&n.isFunction(a.promise)?d:0,g=1===f?a:n.Deferred(),h=function(a,b,c){return function(d){b[a]=this,c[a]=arguments.length>1?e.call(arguments):d,c===i?g.notifyWith(b,c):--f||g.resolveWith(b,c)}},i,j,k;if(d>1)for(i=new Array(d),j=new Array(d),k=new Array(d);d>b;b++)c[b]&&n.isFunction(c[b].promise)?c[b].promise().progress(h(b,j,i)).done(h(b,k,c)).fail(g.reject):--f;return f||g.resolveWith(k,c),g.promise()}});var I;n.fn.ready=function(a){return n.ready.promise().done(a),this},n.extend({isReady:!1,readyWait:1,holdReady:function(a){a?n.readyWait++:n.ready(!0)},ready:function(a){(a===!0?--n.readyWait:n.isReady)||(n.isReady=!0,a!==!0&&--n.readyWait>0||(I.resolveWith(d,[n]),n.fn.triggerHandler&&(n(d).triggerHandler("ready"),n(d).off("ready"))))}});function J(){d.addEventListener?(d.removeEventListener("DOMContentLoaded",K),a.removeEventListener("load",K)):(d.detachEvent("onreadystatechange",K),a.detachEvent("onload",K))}function K(){(d.addEventListener||"load"===a.event.type||"complete"===d.readyState)&&(J(),n.ready())}n.ready.promise=function(b){if(!I)if(I=n.Deferred(),"complete"===d.readyState||"loading"!==d.readyState&&!d.documentElement.doScroll)a.setTimeout(n.ready);else if(d.addEventListener)d.addEventListener("DOMContentLoaded",K),a.addEventListener("load",K);else{d.attachEvent("onreadystatechange",K),a.attachEvent("onload",K);var c=!1;try{c=null==a.frameElement&&d.documentElement}catch(e){}c&&c.doScroll&&!function f(){if(!n.isReady){try{c.doScroll("left")}catch(b){return a.setTimeout(f,50)}J(),n.ready()}}()}return I.promise(b)},n.ready.promise();var L;for(L in n(l))break;l.ownFirst="0"===L,l.inlineBlockNeedsLayout=!1,n(function(){var a,b,c,e;c=d.getElementsByTagName("body")[0],c&&c.style&&(b=d.createElement("div"),e=d.createElement("div"),e.style.cssText="position:absolute;border:0;width:0;height:0;top:0;left:-9999px",c.appendChild(e).appendChild(b),"undefined"!=typeof b.style.zoom&&(b.style.cssText="display:inline;margin:0;border:0;padding:1px;width:1px;zoom:1",l.inlineBlockNeedsLayout=a=3===b.offsetWidth,a&&(c.style.zoom=1)),c.removeChild(e))}),function(){var a=d.createElement("div");l.deleteExpando=!0;try{delete a.test}catch(b){l.deleteExpando=!1}a=null}();var M=function(a){var b=n.noData[(a.nodeName+" ").toLowerCase()],c=+a.nodeType||1;return 1!==c&&9!==c?!1:!b||b!==!0&&a.getAttribute("classid")===b},N=/^(?:\{[\w\W]*\}|\[[\w\W]*\])$/,O=/([A-Z])/g;function P(a,b,c){if(void 0===c&&1===a.nodeType){var d="data-"+b.replace(O,"-$1").toLowerCase();if(c=a.getAttribute(d),"string"==typeof c){try{c="true"===c?!0:"false"===c?!1:"null"===c?null:+c+""===c?+c:N.test(c)?n.parseJSON(c):c}catch(e){}n.data(a,b,c)}else c=void 0;
}return c}function Q(a){var b;for(b in a)if(("data"!==b||!n.isEmptyObject(a[b]))&&"toJSON"!==b)return!1;return!0}function R(a,b,d,e){if(M(a)){var f,g,h=n.expando,i=a.nodeType,j=i?n.cache:a,k=i?a[h]:a[h]&&h;if(k&&j[k]&&(e||j[k].data)||void 0!==d||"string"!=typeof b)return k||(k=i?a[h]=c.pop()||n.guid++:h),j[k]||(j[k]=i?{}:{toJSON:n.noop}),"object"!=typeof b&&"function"!=typeof b||(e?j[k]=n.extend(j[k],b):j[k].data=n.extend(j[k].data,b)),g=j[k],e||(g.data||(g.data={}),g=g.data),void 0!==d&&(g[n.camelCase(b)]=d),"string"==typeof b?(f=g[b],null==f&&(f=g[n.camelCase(b)])):f=g,f}}function S(a,b,c){if(M(a)){var d,e,f=a.nodeType,g=f?n.cache:a,h=f?a[n.expando]:n.expando;if(g[h]){if(b&&(d=c?g[h]:g[h].data)){n.isArray(b)?b=b.concat(n.map(b,n.camelCase)):b in d?b=[b]:(b=n.camelCase(b),b=b in d?[b]:b.split(" ")),e=b.length;while(e--)delete d[b[e]];if(c?!Q(d):!n.isEmptyObject(d))return}(c||(delete g[h].data,Q(g[h])))&&(f?n.cleanData([a],!0):l.deleteExpando||g!=g.window?delete g[h]:g[h]=void 0)}}}n.extend({cache:{},noData:{"applet ":!0,"embed ":!0,"object ":"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"},hasData:function(a){return a=a.nodeType?n.cache[a[n.expando]]:a[n.expando],!!a&&!Q(a)},data:function(a,b,c){return R(a,b,c)},removeData:function(a,b){return S(a,b)},_data:function(a,b,c){return R(a,b,c,!0)},_removeData:function(a,b){return S(a,b,!0)}}),n.fn.extend({data:function(a,b){var c,d,e,f=this[0],g=f&&f.attributes;if(void 0===a){if(this.length&&(e=n.data(f),1===f.nodeType&&!n._data(f,"parsedAttrs"))){c=g.length;while(c--)g[c]&&(d=g[c].name,0===d.indexOf("data-")&&(d=n.camelCase(d.slice(5)),P(f,d,e[d])));n._data(f,"parsedAttrs",!0)}return e}return"object"==typeof a?this.each(function(){n.data(this,a)}):arguments.length>1?this.each(function(){n.data(this,a,b)}):f?P(f,a,n.data(f,a)):void 0},removeData:function(a){return this.each(function(){n.removeData(this,a)})}}),n.extend({queue:function(a,b,c){var d;return a?(b=(b||"fx")+"queue",d=n._data(a,b),c&&(!d||n.isArray(c)?d=n._data(a,b,n.makeArray(c)):d.push(c)),d||[]):void 0},dequeue:function(a,b){b=b||"fx";var c=n.queue(a,b),d=c.length,e=c.shift(),f=n._queueHooks(a,b),g=function(){n.dequeue(a,b)};"inprogress"===e&&(e=c.shift(),d--),e&&("fx"===b&&c.unshift("inprogress"),delete f.stop,e.call(a,g,f)),!d&&f&&f.empty.fire()},_queueHooks:function(a,b){var c=b+"queueHooks";return n._data(a,c)||n._data(a,c,{empty:n.Callbacks("once memory").add(function(){n._removeData(a,b+"queue"),n._removeData(a,c)})})}}),n.fn.extend({queue:function(a,b){var c=2;return"string"!=typeof a&&(b=a,a="fx",c--),arguments.length<c?n.queue(this[0],a):void 0===b?this:this.each(function(){var c=n.queue(this,a,b);n._queueHooks(this,a),"fx"===a&&"inprogress"!==c[0]&&n.dequeue(this,a)})},dequeue:function(a){return this.each(function(){n.dequeue(this,a)})},clearQueue:function(a){return this.queue(a||"fx",[])},promise:function(a,b){var c,d=1,e=n.Deferred(),f=this,g=this.length,h=function(){--d||e.resolveWith(f,[f])};"string"!=typeof a&&(b=a,a=void 0),a=a||"fx";while(g--)c=n._data(f[g],a+"queueHooks"),c&&c.empty&&(d++,c.empty.add(h));return h(),e.promise(b)}}),function(){var a;l.shrinkWrapBlocks=function(){if(null!=a)return a;a=!1;var b,c,e;return c=d.getElementsByTagName("body")[0],c&&c.style?(b=d.createElement("div"),e=d.createElement("div"),e.style.cssText="position:absolute;border:0;width:0;height:0;top:0;left:-9999px",c.appendChild(e).appendChild(b),"undefined"!=typeof b.style.zoom&&(b.style.cssText="-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:1px;width:1px;zoom:1",b.appendChild(d.createElement("div")).style.width="5px",a=3!==b.offsetWidth),c.removeChild(e),a):void 0}}();var T=/[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source,U=new RegExp("^(?:([+-])=|)("+T+")([a-z%]*)$","i"),V=["Top","Right","Bottom","Left"],W=function(a,b){return a=b||a,"none"===n.css(a,"display")||!n.contains(a.ownerDocument,a)};function X(a,b,c,d){var e,f=1,g=20,h=d?function(){return d.cur()}:function(){return n.css(a,b,"")},i=h(),j=c&&c[3]||(n.cssNumber[b]?"":"px"),k=(n.cssNumber[b]||"px"!==j&&+i)&&U.exec(n.css(a,b));if(k&&k[3]!==j){j=j||k[3],c=c||[],k=+i||1;do f=f||".5",k/=f,n.style(a,b,k+j);while(f!==(f=h()/i)&&1!==f&&--g)}return c&&(k=+k||+i||0,e=c[1]?k+(c[1]+1)*c[2]:+c[2],d&&(d.unit=j,d.start=k,d.end=e)),e}var Y=function(a,b,c,d,e,f,g){var h=0,i=a.length,j=null==c;if("object"===n.type(c)){e=!0;for(h in c)Y(a,b,h,c[h],!0,f,g)}else if(void 0!==d&&(e=!0,n.isFunction(d)||(g=!0),j&&(g?(b.call(a,d),b=null):(j=b,b=function(a,b,c){return j.call(n(a),c)})),b))for(;i>h;h++)b(a[h],c,g?d:d.call(a[h],h,b(a[h],c)));return e?a:j?b.call(a):i?b(a[0],c):f},Z=/^(?:checkbox|radio)$/i,$=/<([\w:-]+)/,_=/^$|\/(?:java|ecma)script/i,aa=/^\s+/,ba="abbr|article|aside|audio|bdi|canvas|data|datalist|details|dialog|figcaption|figure|footer|header|hgroup|main|mark|meter|nav|output|picture|progress|section|summary|template|time|video";function ca(a){var b=ba.split("|"),c=a.createDocumentFragment();if(c.createElement)while(b.length)c.createElement(b.pop());return c}!function(){var a=d.createElement("div"),b=d.createDocumentFragment(),c=d.createElement("input");a.innerHTML="  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>",l.leadingWhitespace=3===a.firstChild.nodeType,l.tbody=!a.getElementsByTagName("tbody").length,l.htmlSerialize=!!a.getElementsByTagName("link").length,l.html5Clone="<:nav></:nav>"!==d.createElement("nav").cloneNode(!0).outerHTML,c.type="checkbox",c.checked=!0,b.appendChild(c),l.appendChecked=c.checked,a.innerHTML="<textarea>x</textarea>",l.noCloneChecked=!!a.cloneNode(!0).lastChild.defaultValue,b.appendChild(a),c=d.createElement("input"),c.setAttribute("type","radio"),c.setAttribute("checked","checked"),c.setAttribute("name","t"),a.appendChild(c),l.checkClone=a.cloneNode(!0).cloneNode(!0).lastChild.checked,l.noCloneEvent=!!a.addEventListener,a[n.expando]=1,l.attributes=!a.getAttribute(n.expando)}();var da={option:[1,"<select multiple='multiple'>","</select>"],legend:[1,"<fieldset>","</fieldset>"],area:[1,"<map>","</map>"],param:[1,"<object>","</object>"],thead:[1,"<table>","</table>"],tr:[2,"<table><tbody>","</tbody></table>"],col:[2,"<table><tbody></tbody><colgroup>","</colgroup></table>"],td:[3,"<table><tbody><tr>","</tr></tbody></table>"],_default:l.htmlSerialize?[0,"",""]:[1,"X<div>","</div>"]};da.optgroup=da.option,da.tbody=da.tfoot=da.colgroup=da.caption=da.thead,da.th=da.td;function ea(a,b){var c,d,e=0,f="undefined"!=typeof a.getElementsByTagName?a.getElementsByTagName(b||"*"):"undefined"!=typeof a.querySelectorAll?a.querySelectorAll(b||"*"):void 0;if(!f)for(f=[],c=a.childNodes||a;null!=(d=c[e]);e++)!b||n.nodeName(d,b)?f.push(d):n.merge(f,ea(d,b));return void 0===b||b&&n.nodeName(a,b)?n.merge([a],f):f}function fa(a,b){for(var c,d=0;null!=(c=a[d]);d++)n._data(c,"globalEval",!b||n._data(b[d],"globalEval"))}var ga=/<|&#?\w+;/,ha=/<tbody/i;function ia(a){Z.test(a.type)&&(a.defaultChecked=a.checked)}function ja(a,b,c,d,e){for(var f,g,h,i,j,k,m,o=a.length,p=ca(b),q=[],r=0;o>r;r++)if(g=a[r],g||0===g)if("object"===n.type(g))n.merge(q,g.nodeType?[g]:g);else if(ga.test(g)){i=i||p.appendChild(b.createElement("div")),j=($.exec(g)||["",""])[1].toLowerCase(),m=da[j]||da._default,i.innerHTML=m[1]+n.htmlPrefilter(g)+m[2],f=m[0];while(f--)i=i.lastChild;if(!l.leadingWhitespace&&aa.test(g)&&q.push(b.createTextNode(aa.exec(g)[0])),!l.tbody){g="table"!==j||ha.test(g)?"<table>"!==m[1]||ha.test(g)?0:i:i.firstChild,f=g&&g.childNodes.length;while(f--)n.nodeName(k=g.childNodes[f],"tbody")&&!k.childNodes.length&&g.removeChild(k)}n.merge(q,i.childNodes),i.textContent="";while(i.firstChild)i.removeChild(i.firstChild);i=p.lastChild}else q.push(b.createTextNode(g));i&&p.removeChild(i),l.appendChecked||n.grep(ea(q,"input"),ia),r=0;while(g=q[r++])if(d&&n.inArray(g,d)>-1)e&&e.push(g);else if(h=n.contains(g.ownerDocument,g),i=ea(p.appendChild(g),"script"),h&&fa(i),c){f=0;while(g=i[f++])_.test(g.type||"")&&c.push(g)}return i=null,p}!function(){var b,c,e=d.createElement("div");for(b in{submit:!0,change:!0,focusin:!0})c="on"+b,(l[b]=c in a)||(e.setAttribute(c,"t"),l[b]=e.attributes[c].expando===!1);e=null}();var ka=/^(?:input|select|textarea)$/i,la=/^key/,ma=/^(?:mouse|pointer|contextmenu|drag|drop)|click/,na=/^(?:focusinfocus|focusoutblur)$/,oa=/^([^.]*)(?:\.(.+)|)/;function pa(){return!0}function qa(){return!1}function ra(){try{return d.activeElement}catch(a){}}function sa(a,b,c,d,e,f){var g,h;if("object"==typeof b){"string"!=typeof c&&(d=d||c,c=void 0);for(h in b)sa(a,h,c,d,b[h],f);return a}if(null==d&&null==e?(e=c,d=c=void 0):null==e&&("string"==typeof c?(e=d,d=void 0):(e=d,d=c,c=void 0)),e===!1)e=qa;else if(!e)return a;return 1===f&&(g=e,e=function(a){return n().off(a),g.apply(this,arguments)},e.guid=g.guid||(g.guid=n.guid++)),a.each(function(){n.event.add(this,b,e,d,c)})}n.event={global:{},add:function(a,b,c,d,e){var f,g,h,i,j,k,l,m,o,p,q,r=n._data(a);if(r){c.handler&&(i=c,c=i.handler,e=i.selector),c.guid||(c.guid=n.guid++),(g=r.events)||(g=r.events={}),(k=r.handle)||(k=r.handle=function(a){return"undefined"==typeof n||a&&n.event.triggered===a.type?void 0:n.event.dispatch.apply(k.elem,arguments)},k.elem=a),b=(b||"").match(G)||[""],h=b.length;while(h--)f=oa.exec(b[h])||[],o=q=f[1],p=(f[2]||"").split(".").sort(),o&&(j=n.event.special[o]||{},o=(e?j.delegateType:j.bindType)||o,j=n.event.special[o]||{},l=n.extend({type:o,origType:q,data:d,handler:c,guid:c.guid,selector:e,needsContext:e&&n.expr.match.needsContext.test(e),namespace:p.join(".")},i),(m=g[o])||(m=g[o]=[],m.delegateCount=0,j.setup&&j.setup.call(a,d,p,k)!==!1||(a.addEventListener?a.addEventListener(o,k,!1):a.attachEvent&&a.attachEvent("on"+o,k))),j.add&&(j.add.call(a,l),l.handler.guid||(l.handler.guid=c.guid)),e?m.splice(m.delegateCount++,0,l):m.push(l),n.event.global[o]=!0);a=null}},remove:function(a,b,c,d,e){var f,g,h,i,j,k,l,m,o,p,q,r=n.hasData(a)&&n._data(a);if(r&&(k=r.events)){b=(b||"").match(G)||[""],j=b.length;while(j--)if(h=oa.exec(b[j])||[],o=q=h[1],p=(h[2]||"").split(".").sort(),o){l=n.event.special[o]||{},o=(d?l.delegateType:l.bindType)||o,m=k[o]||[],h=h[2]&&new RegExp("(^|\\.)"+p.join("\\.(?:.*\\.|)")+"(\\.|$)"),i=f=m.length;while(f--)g=m[f],!e&&q!==g.origType||c&&c.guid!==g.guid||h&&!h.test(g.namespace)||d&&d!==g.selector&&("**"!==d||!g.selector)||(m.splice(f,1),g.selector&&m.delegateCount--,l.remove&&l.remove.call(a,g));i&&!m.length&&(l.teardown&&l.teardown.call(a,p,r.handle)!==!1||n.removeEvent(a,o,r.handle),delete k[o])}else for(o in k)n.event.remove(a,o+b[j],c,d,!0);n.isEmptyObject(k)&&(delete r.handle,n._removeData(a,"events"))}},trigger:function(b,c,e,f){var g,h,i,j,l,m,o,p=[e||d],q=k.call(b,"type")?b.type:b,r=k.call(b,"namespace")?b.namespace.split("."):[];if(i=m=e=e||d,3!==e.nodeType&&8!==e.nodeType&&!na.test(q+n.event.triggered)&&(q.indexOf(".")>-1&&(r=q.split("."),q=r.shift(),r.sort()),h=q.indexOf(":")<0&&"on"+q,b=b[n.expando]?b:new n.Event(q,"object"==typeof b&&b),b.isTrigger=f?2:3,b.namespace=r.join("."),b.rnamespace=b.namespace?new RegExp("(^|\\.)"+r.join("\\.(?:.*\\.|)")+"(\\.|$)"):null,b.result=void 0,b.target||(b.target=e),c=null==c?[b]:n.makeArray(c,[b]),l=n.event.special[q]||{},f||!l.trigger||l.trigger.apply(e,c)!==!1)){if(!f&&!l.noBubble&&!n.isWindow(e)){for(j=l.delegateType||q,na.test(j+q)||(i=i.parentNode);i;i=i.parentNode)p.push(i),m=i;m===(e.ownerDocument||d)&&p.push(m.defaultView||m.parentWindow||a)}o=0;while((i=p[o++])&&!b.isPropagationStopped())b.type=o>1?j:l.bindType||q,g=(n._data(i,"events")||{})[b.type]&&n._data(i,"handle"),g&&g.apply(i,c),g=h&&i[h],g&&g.apply&&M(i)&&(b.result=g.apply(i,c),b.result===!1&&b.preventDefault());if(b.type=q,!f&&!b.isDefaultPrevented()&&(!l._default||l._default.apply(p.pop(),c)===!1)&&M(e)&&h&&e[q]&&!n.isWindow(e)){m=e[h],m&&(e[h]=null),n.event.triggered=q;try{e[q]()}catch(s){}n.event.triggered=void 0,m&&(e[h]=m)}return b.result}},dispatch:function(a){a=n.event.fix(a);var b,c,d,f,g,h=[],i=e.call(arguments),j=(n._data(this,"events")||{})[a.type]||[],k=n.event.special[a.type]||{};if(i[0]=a,a.delegateTarget=this,!k.preDispatch||k.preDispatch.call(this,a)!==!1){h=n.event.handlers.call(this,a,j),b=0;while((f=h[b++])&&!a.isPropagationStopped()){a.currentTarget=f.elem,c=0;while((g=f.handlers[c++])&&!a.isImmediatePropagationStopped())a.rnamespace&&!a.rnamespace.test(g.namespace)||(a.handleObj=g,a.data=g.data,d=((n.event.special[g.origType]||{}).handle||g.handler).apply(f.elem,i),void 0!==d&&(a.result=d)===!1&&(a.preventDefault(),a.stopPropagation()))}return k.postDispatch&&k.postDispatch.call(this,a),a.result}},handlers:function(a,b){var c,d,e,f,g=[],h=b.delegateCount,i=a.target;if(h&&i.nodeType&&("click"!==a.type||isNaN(a.button)||a.button<1))for(;i!=this;i=i.parentNode||this)if(1===i.nodeType&&(i.disabled!==!0||"click"!==a.type)){for(d=[],c=0;h>c;c++)f=b[c],e=f.selector+" ",void 0===d[e]&&(d[e]=f.needsContext?n(e,this).index(i)>-1:n.find(e,this,null,[i]).length),d[e]&&d.push(f);d.length&&g.push({elem:i,handlers:d})}return h<b.length&&g.push({elem:this,handlers:b.slice(h)}),g},fix:function(a){if(a[n.expando])return a;var b,c,e,f=a.type,g=a,h=this.fixHooks[f];h||(this.fixHooks[f]=h=ma.test(f)?this.mouseHooks:la.test(f)?this.keyHooks:{}),e=h.props?this.props.concat(h.props):this.props,a=new n.Event(g),b=e.length;while(b--)c=e[b],a[c]=g[c];return a.target||(a.target=g.srcElement||d),3===a.target.nodeType&&(a.target=a.target.parentNode),a.metaKey=!!a.metaKey,h.filter?h.filter(a,g):a},props:"altKey bubbles cancelable ctrlKey currentTarget detail eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),fixHooks:{},keyHooks:{props:"char charCode key keyCode".split(" "),filter:function(a,b){return null==a.which&&(a.which=null!=b.charCode?b.charCode:b.keyCode),a}},mouseHooks:{props:"button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),filter:function(a,b){var c,e,f,g=b.button,h=b.fromElement;return null==a.pageX&&null!=b.clientX&&(e=a.target.ownerDocument||d,f=e.documentElement,c=e.body,a.pageX=b.clientX+(f&&f.scrollLeft||c&&c.scrollLeft||0)-(f&&f.clientLeft||c&&c.clientLeft||0),a.pageY=b.clientY+(f&&f.scrollTop||c&&c.scrollTop||0)-(f&&f.clientTop||c&&c.clientTop||0)),!a.relatedTarget&&h&&(a.relatedTarget=h===a.target?b.toElement:h),a.which||void 0===g||(a.which=1&g?1:2&g?3:4&g?2:0),a}},special:{load:{noBubble:!0},focus:{trigger:function(){if(this!==ra()&&this.focus)try{return this.focus(),!1}catch(a){}},delegateType:"focusin"},blur:{trigger:function(){return this===ra()&&this.blur?(this.blur(),!1):void 0},delegateType:"focusout"},click:{trigger:function(){return n.nodeName(this,"input")&&"checkbox"===this.type&&this.click?(this.click(),!1):void 0},_default:function(a){return n.nodeName(a.target,"a")}},beforeunload:{postDispatch:function(a){void 0!==a.result&&a.originalEvent&&(a.originalEvent.returnValue=a.result)}}},simulate:function(a,b,c){var d=n.extend(new n.Event,c,{type:a,isSimulated:!0});n.event.trigger(d,null,b),d.isDefaultPrevented()&&c.preventDefault()}},n.removeEvent=d.removeEventListener?function(a,b,c){a.removeEventListener&&a.removeEventListener(b,c)}:function(a,b,c){var d="on"+b;a.detachEvent&&("undefined"==typeof a[d]&&(a[d]=null),a.detachEvent(d,c))},n.Event=function(a,b){return this instanceof n.Event?(a&&a.type?(this.originalEvent=a,this.type=a.type,this.isDefaultPrevented=a.defaultPrevented||void 0===a.defaultPrevented&&a.returnValue===!1?pa:qa):this.type=a,b&&n.extend(this,b),this.timeStamp=a&&a.timeStamp||n.now(),void(this[n.expando]=!0)):new n.Event(a,b)},n.Event.prototype={constructor:n.Event,isDefaultPrevented:qa,isPropagationStopped:qa,isImmediatePropagationStopped:qa,preventDefault:function(){var a=this.originalEvent;this.isDefaultPrevented=pa,a&&(a.preventDefault?a.preventDefault():a.returnValue=!1)},stopPropagation:function(){var a=this.originalEvent;this.isPropagationStopped=pa,a&&!this.isSimulated&&(a.stopPropagation&&a.stopPropagation(),a.cancelBubble=!0)},stopImmediatePropagation:function(){var a=this.originalEvent;this.isImmediatePropagationStopped=pa,a&&a.stopImmediatePropagation&&a.stopImmediatePropagation(),this.stopPropagation()}},n.each({mouseenter:"mouseover",mouseleave:"mouseout",pointerenter:"pointerover",pointerleave:"pointerout"},function(a,b){n.event.special[a]={delegateType:b,bindType:b,handle:function(a){var c,d=this,e=a.relatedTarget,f=a.handleObj;return e&&(e===d||n.contains(d,e))||(a.type=f.origType,c=f.handler.apply(this,arguments),a.type=b),c}}}),l.submit||(n.event.special.submit={setup:function(){return n.nodeName(this,"form")?!1:void n.event.add(this,"click._submit keypress._submit",function(a){var b=a.target,c=n.nodeName(b,"input")||n.nodeName(b,"button")?n.prop(b,"form"):void 0;c&&!n._data(c,"submit")&&(n.event.add(c,"submit._submit",function(a){a._submitBubble=!0}),n._data(c,"submit",!0))})},postDispatch:function(a){a._submitBubble&&(delete a._submitBubble,this.parentNode&&!a.isTrigger&&n.event.simulate("submit",this.parentNode,a))},teardown:function(){return n.nodeName(this,"form")?!1:void n.event.remove(this,"._submit")}}),l.change||(n.event.special.change={setup:function(){return ka.test(this.nodeName)?("checkbox"!==this.type&&"radio"!==this.type||(n.event.add(this,"propertychange._change",function(a){"checked"===a.originalEvent.propertyName&&(this._justChanged=!0)}),n.event.add(this,"click._change",function(a){this._justChanged&&!a.isTrigger&&(this._justChanged=!1),n.event.simulate("change",this,a)})),!1):void n.event.add(this,"beforeactivate._change",function(a){var b=a.target;ka.test(b.nodeName)&&!n._data(b,"change")&&(n.event.add(b,"change._change",function(a){!this.parentNode||a.isSimulated||a.isTrigger||n.event.simulate("change",this.parentNode,a)}),n._data(b,"change",!0))})},handle:function(a){var b=a.target;return this!==b||a.isSimulated||a.isTrigger||"radio"!==b.type&&"checkbox"!==b.type?a.handleObj.handler.apply(this,arguments):void 0},teardown:function(){return n.event.remove(this,"._change"),!ka.test(this.nodeName)}}),l.focusin||n.each({focus:"focusin",blur:"focusout"},function(a,b){var c=function(a){n.event.simulate(b,a.target,n.event.fix(a))};n.event.special[b]={setup:function(){var d=this.ownerDocument||this,e=n._data(d,b);e||d.addEventListener(a,c,!0),n._data(d,b,(e||0)+1)},teardown:function(){var d=this.ownerDocument||this,e=n._data(d,b)-1;e?n._data(d,b,e):(d.removeEventListener(a,c,!0),n._removeData(d,b))}}}),n.fn.extend({on:function(a,b,c,d){return sa(this,a,b,c,d)},one:function(a,b,c,d){return sa(this,a,b,c,d,1)},off:function(a,b,c){var d,e;if(a&&a.preventDefault&&a.handleObj)return d=a.handleObj,n(a.delegateTarget).off(d.namespace?d.origType+"."+d.namespace:d.origType,d.selector,d.handler),this;if("object"==typeof a){for(e in a)this.off(e,b,a[e]);return this}return b!==!1&&"function"!=typeof b||(c=b,b=void 0),c===!1&&(c=qa),this.each(function(){n.event.remove(this,a,c,b)})},trigger:function(a,b){return this.each(function(){n.event.trigger(a,b,this)})},triggerHandler:function(a,b){var c=this[0];return c?n.event.trigger(a,b,c,!0):void 0}});var ta=/ jQuery\d+="(?:null|\d+)"/g,ua=new RegExp("<(?:"+ba+")[\\s/>]","i"),va=/<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:-]+)[^>]*)\/>/gi,wa=/<script|<style|<link/i,xa=/checked\s*(?:[^=]|=\s*.checked.)/i,ya=/^true\/(.*)/,za=/^\s*<!(?:\[CDATA\[|--)|(?:\]\]|--)>\s*$/g,Aa=ca(d),Ba=Aa.appendChild(d.createElement("div"));function Ca(a,b){return n.nodeName(a,"table")&&n.nodeName(11!==b.nodeType?b:b.firstChild,"tr")?a.getElementsByTagName("tbody")[0]||a.appendChild(a.ownerDocument.createElement("tbody")):a}function Da(a){return a.type=(null!==n.find.attr(a,"type"))+"/"+a.type,a}function Ea(a){var b=ya.exec(a.type);return b?a.type=b[1]:a.removeAttribute("type"),a}function Fa(a,b){if(1===b.nodeType&&n.hasData(a)){var c,d,e,f=n._data(a),g=n._data(b,f),h=f.events;if(h){delete g.handle,g.events={};for(c in h)for(d=0,e=h[c].length;e>d;d++)n.event.add(b,c,h[c][d])}g.data&&(g.data=n.extend({},g.data))}}function Ga(a,b){var c,d,e;if(1===b.nodeType){if(c=b.nodeName.toLowerCase(),!l.noCloneEvent&&b[n.expando]){e=n._data(b);for(d in e.events)n.removeEvent(b,d,e.handle);b.removeAttribute(n.expando)}"script"===c&&b.text!==a.text?(Da(b).text=a.text,Ea(b)):"object"===c?(b.parentNode&&(b.outerHTML=a.outerHTML),l.html5Clone&&a.innerHTML&&!n.trim(b.innerHTML)&&(b.innerHTML=a.innerHTML)):"input"===c&&Z.test(a.type)?(b.defaultChecked=b.checked=a.checked,b.value!==a.value&&(b.value=a.value)):"option"===c?b.defaultSelected=b.selected=a.defaultSelected:"input"!==c&&"textarea"!==c||(b.defaultValue=a.defaultValue)}}function Ha(a,b,c,d){b=f.apply([],b);var e,g,h,i,j,k,m=0,o=a.length,p=o-1,q=b[0],r=n.isFunction(q);if(r||o>1&&"string"==typeof q&&!l.checkClone&&xa.test(q))return a.each(function(e){var f=a.eq(e);r&&(b[0]=q.call(this,e,f.html())),Ha(f,b,c,d)});if(o&&(k=ja(b,a[0].ownerDocument,!1,a,d),e=k.firstChild,1===k.childNodes.length&&(k=e),e||d)){for(i=n.map(ea(k,"script"),Da),h=i.length;o>m;m++)g=k,m!==p&&(g=n.clone(g,!0,!0),h&&n.merge(i,ea(g,"script"))),c.call(a[m],g,m);if(h)for(j=i[i.length-1].ownerDocument,n.map(i,Ea),m=0;h>m;m++)g=i[m],_.test(g.type||"")&&!n._data(g,"globalEval")&&n.contains(j,g)&&(g.src?n._evalUrl&&n._evalUrl(g.src):n.globalEval((g.text||g.textContent||g.innerHTML||"").replace(za,"")));k=e=null}return a}function Ia(a,b,c){for(var d,e=b?n.filter(b,a):a,f=0;null!=(d=e[f]);f++)c||1!==d.nodeType||n.cleanData(ea(d)),d.parentNode&&(c&&n.contains(d.ownerDocument,d)&&fa(ea(d,"script")),d.parentNode.removeChild(d));return a}n.extend({htmlPrefilter:function(a){return a.replace(va,"<$1></$2>")},clone:function(a,b,c){var d,e,f,g,h,i=n.contains(a.ownerDocument,a);if(l.html5Clone||n.isXMLDoc(a)||!ua.test("<"+a.nodeName+">")?f=a.cloneNode(!0):(Ba.innerHTML=a.outerHTML,Ba.removeChild(f=Ba.firstChild)),!(l.noCloneEvent&&l.noCloneChecked||1!==a.nodeType&&11!==a.nodeType||n.isXMLDoc(a)))for(d=ea(f),h=ea(a),g=0;null!=(e=h[g]);++g)d[g]&&Ga(e,d[g]);if(b)if(c)for(h=h||ea(a),d=d||ea(f),g=0;null!=(e=h[g]);g++)Fa(e,d[g]);else Fa(a,f);return d=ea(f,"script"),d.length>0&&fa(d,!i&&ea(a,"script")),d=h=e=null,f},cleanData:function(a,b){for(var d,e,f,g,h=0,i=n.expando,j=n.cache,k=l.attributes,m=n.event.special;null!=(d=a[h]);h++)if((b||M(d))&&(f=d[i],g=f&&j[f])){if(g.events)for(e in g.events)m[e]?n.event.remove(d,e):n.removeEvent(d,e,g.handle);j[f]&&(delete j[f],k||"undefined"==typeof d.removeAttribute?d[i]=void 0:d.removeAttribute(i),c.push(f))}}}),n.fn.extend({domManip:Ha,detach:function(a){return Ia(this,a,!0)},remove:function(a){return Ia(this,a)},text:function(a){return Y(this,function(a){return void 0===a?n.text(this):this.empty().append((this[0]&&this[0].ownerDocument||d).createTextNode(a))},null,a,arguments.length)},append:function(){return Ha(this,arguments,function(a){if(1===this.nodeType||11===this.nodeType||9===this.nodeType){var b=Ca(this,a);b.appendChild(a)}})},prepend:function(){return Ha(this,arguments,function(a){if(1===this.nodeType||11===this.nodeType||9===this.nodeType){var b=Ca(this,a);b.insertBefore(a,b.firstChild)}})},before:function(){return Ha(this,arguments,function(a){this.parentNode&&this.parentNode.insertBefore(a,this)})},after:function(){return Ha(this,arguments,function(a){this.parentNode&&this.parentNode.insertBefore(a,this.nextSibling)})},empty:function(){for(var a,b=0;null!=(a=this[b]);b++){1===a.nodeType&&n.cleanData(ea(a,!1));while(a.firstChild)a.removeChild(a.firstChild);a.options&&n.nodeName(a,"select")&&(a.options.length=0)}return this},clone:function(a,b){return a=null==a?!1:a,b=null==b?a:b,this.map(function(){return n.clone(this,a,b)})},html:function(a){return Y(this,function(a){var b=this[0]||{},c=0,d=this.length;if(void 0===a)return 1===b.nodeType?b.innerHTML.replace(ta,""):void 0;if("string"==typeof a&&!wa.test(a)&&(l.htmlSerialize||!ua.test(a))&&(l.leadingWhitespace||!aa.test(a))&&!da[($.exec(a)||["",""])[1].toLowerCase()]){a=n.htmlPrefilter(a);try{for(;d>c;c++)b=this[c]||{},1===b.nodeType&&(n.cleanData(ea(b,!1)),b.innerHTML=a);b=0}catch(e){}}b&&this.empty().append(a)},null,a,arguments.length)},replaceWith:function(){var a=[];return Ha(this,arguments,function(b){var c=this.parentNode;n.inArray(this,a)<0&&(n.cleanData(ea(this)),c&&c.replaceChild(b,this))},a)}}),n.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(a,b){n.fn[a]=function(a){for(var c,d=0,e=[],f=n(a),h=f.length-1;h>=d;d++)c=d===h?this:this.clone(!0),n(f[d])[b](c),g.apply(e,c.get());return this.pushStack(e)}});var Ja,Ka={HTML:"block",BODY:"block"};function La(a,b){var c=n(b.createElement(a)).appendTo(b.body),d=n.css(c[0],"display");return c.detach(),d}function Ma(a){var b=d,c=Ka[a];return c||(c=La(a,b),"none"!==c&&c||(Ja=(Ja||n("<iframe frameborder='0' width='0' height='0'/>")).appendTo(b.documentElement),b=(Ja[0].contentWindow||Ja[0].contentDocument).document,b.write(),b.close(),c=La(a,b),Ja.detach()),Ka[a]=c),c}var Na=/^margin/,Oa=new RegExp("^("+T+")(?!px)[a-z%]+$","i"),Pa=function(a,b,c,d){var e,f,g={};for(f in b)g[f]=a.style[f],a.style[f]=b[f];e=c.apply(a,d||[]);for(f in b)a.style[f]=g[f];return e},Qa=d.documentElement;!function(){var b,c,e,f,g,h,i=d.createElement("div"),j=d.createElement("div");if(j.style){j.style.cssText="float:left;opacity:.5",l.opacity="0.5"===j.style.opacity,l.cssFloat=!!j.style.cssFloat,j.style.backgroundClip="content-box",j.cloneNode(!0).style.backgroundClip="",l.clearCloneStyle="content-box"===j.style.backgroundClip,i=d.createElement("div"),i.style.cssText="border:0;width:8px;height:0;top:0;left:-9999px;padding:0;margin-top:1px;position:absolute",j.innerHTML="",i.appendChild(j),l.boxSizing=""===j.style.boxSizing||""===j.style.MozBoxSizing||""===j.style.WebkitBoxSizing,n.extend(l,{reliableHiddenOffsets:function(){return null==b&&k(),f},boxSizingReliable:function(){return null==b&&k(),e},pixelMarginRight:function(){return null==b&&k(),c},pixelPosition:function(){return null==b&&k(),b},reliableMarginRight:function(){return null==b&&k(),g},reliableMarginLeft:function(){return null==b&&k(),h}});function k(){var k,l,m=d.documentElement;m.appendChild(i),j.style.cssText="-webkit-box-sizing:border-box;box-sizing:border-box;position:relative;display:block;margin:auto;border:1px;padding:1px;top:1%;width:50%",b=e=h=!1,c=g=!0,a.getComputedStyle&&(l=a.getComputedStyle(j),b="1%"!==(l||{}).top,h="2px"===(l||{}).marginLeft,e="4px"===(l||{width:"4px"}).width,j.style.marginRight="50%",c="4px"===(l||{marginRight:"4px"}).marginRight,k=j.appendChild(d.createElement("div")),k.style.cssText=j.style.cssText="-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:0",k.style.marginRight=k.style.width="0",j.style.width="1px",g=!parseFloat((a.getComputedStyle(k)||{}).marginRight),j.removeChild(k)),j.style.display="none",f=0===j.getClientRects().length,f&&(j.style.display="",j.innerHTML="<table><tr><td></td><td>t</td></tr></table>",j.childNodes[0].style.borderCollapse="separate",k=j.getElementsByTagName("td"),k[0].style.cssText="margin:0;border:0;padding:0;display:none",f=0===k[0].offsetHeight,f&&(k[0].style.display="",k[1].style.display="none",f=0===k[0].offsetHeight)),m.removeChild(i)}}}();var Ra,Sa,Ta=/^(top|right|bottom|left)$/;a.getComputedStyle?(Ra=function(b){var c=b.ownerDocument.defaultView;return c&&c.opener||(c=a),c.getComputedStyle(b)},Sa=function(a,b,c){var d,e,f,g,h=a.style;return c=c||Ra(a),g=c?c.getPropertyValue(b)||c[b]:void 0,""!==g&&void 0!==g||n.contains(a.ownerDocument,a)||(g=n.style(a,b)),c&&!l.pixelMarginRight()&&Oa.test(g)&&Na.test(b)&&(d=h.width,e=h.minWidth,f=h.maxWidth,h.minWidth=h.maxWidth=h.width=g,g=c.width,h.width=d,h.minWidth=e,h.maxWidth=f),void 0===g?g:g+""}):Qa.currentStyle&&(Ra=function(a){return a.currentStyle},Sa=function(a,b,c){var d,e,f,g,h=a.style;return c=c||Ra(a),g=c?c[b]:void 0,null==g&&h&&h[b]&&(g=h[b]),Oa.test(g)&&!Ta.test(b)&&(d=h.left,e=a.runtimeStyle,f=e&&e.left,f&&(e.left=a.currentStyle.left),h.left="fontSize"===b?"1em":g,g=h.pixelLeft+"px",h.left=d,f&&(e.left=f)),void 0===g?g:g+""||"auto"});function Ua(a,b){return{get:function(){return a()?void delete this.get:(this.get=b).apply(this,arguments)}}}var Va=/alpha\([^)]*\)/i,Wa=/opacity\s*=\s*([^)]*)/i,Xa=/^(none|table(?!-c[ea]).+)/,Ya=new RegExp("^("+T+")(.*)$","i"),Za={position:"absolute",visibility:"hidden",display:"block"},$a={letterSpacing:"0",fontWeight:"400"},_a=["Webkit","O","Moz","ms"],ab=d.createElement("div").style;function bb(a){if(a in ab)return a;var b=a.charAt(0).toUpperCase()+a.slice(1),c=_a.length;while(c--)if(a=_a[c]+b,a in ab)return a}function cb(a,b){for(var c,d,e,f=[],g=0,h=a.length;h>g;g++)d=a[g],d.style&&(f[g]=n._data(d,"olddisplay"),c=d.style.display,b?(f[g]||"none"!==c||(d.style.display=""),""===d.style.display&&W(d)&&(f[g]=n._data(d,"olddisplay",Ma(d.nodeName)))):(e=W(d),(c&&"none"!==c||!e)&&n._data(d,"olddisplay",e?c:n.css(d,"display"))));for(g=0;h>g;g++)d=a[g],d.style&&(b&&"none"!==d.style.display&&""!==d.style.display||(d.style.display=b?f[g]||"":"none"));return a}function db(a,b,c){var d=Ya.exec(b);return d?Math.max(0,d[1]-(c||0))+(d[2]||"px"):b}function eb(a,b,c,d,e){for(var f=c===(d?"border":"content")?4:"width"===b?1:0,g=0;4>f;f+=2)"margin"===c&&(g+=n.css(a,c+V[f],!0,e)),d?("content"===c&&(g-=n.css(a,"padding"+V[f],!0,e)),"margin"!==c&&(g-=n.css(a,"border"+V[f]+"Width",!0,e))):(g+=n.css(a,"padding"+V[f],!0,e),"padding"!==c&&(g+=n.css(a,"border"+V[f]+"Width",!0,e)));return g}function fb(a,b,c){var d=!0,e="width"===b?a.offsetWidth:a.offsetHeight,f=Ra(a),g=l.boxSizing&&"border-box"===n.css(a,"boxSizing",!1,f);if(0>=e||null==e){if(e=Sa(a,b,f),(0>e||null==e)&&(e=a.style[b]),Oa.test(e))return e;d=g&&(l.boxSizingReliable()||e===a.style[b]),e=parseFloat(e)||0}return e+eb(a,b,c||(g?"border":"content"),d,f)+"px"}n.extend({cssHooks:{opacity:{get:function(a,b){if(b){var c=Sa(a,"opacity");return""===c?"1":c}}}},cssNumber:{animationIterationCount:!0,columnCount:!0,fillOpacity:!0,flexGrow:!0,flexShrink:!0,fontWeight:!0,lineHeight:!0,opacity:!0,order:!0,orphans:!0,widows:!0,zIndex:!0,zoom:!0},cssProps:{"float":l.cssFloat?"cssFloat":"styleFloat"},style:function(a,b,c,d){if(a&&3!==a.nodeType&&8!==a.nodeType&&a.style){var e,f,g,h=n.camelCase(b),i=a.style;if(b=n.cssProps[h]||(n.cssProps[h]=bb(h)||h),g=n.cssHooks[b]||n.cssHooks[h],void 0===c)return g&&"get"in g&&void 0!==(e=g.get(a,!1,d))?e:i[b];if(f=typeof c,"string"===f&&(e=U.exec(c))&&e[1]&&(c=X(a,b,e),f="number"),null!=c&&c===c&&("number"===f&&(c+=e&&e[3]||(n.cssNumber[h]?"":"px")),l.clearCloneStyle||""!==c||0!==b.indexOf("background")||(i[b]="inherit"),!(g&&"set"in g&&void 0===(c=g.set(a,c,d)))))try{i[b]=c}catch(j){}}},css:function(a,b,c,d){var e,f,g,h=n.camelCase(b);return b=n.cssProps[h]||(n.cssProps[h]=bb(h)||h),g=n.cssHooks[b]||n.cssHooks[h],g&&"get"in g&&(f=g.get(a,!0,c)),void 0===f&&(f=Sa(a,b,d)),"normal"===f&&b in $a&&(f=$a[b]),""===c||c?(e=parseFloat(f),c===!0||isFinite(e)?e||0:f):f}}),n.each(["height","width"],function(a,b){n.cssHooks[b]={get:function(a,c,d){return c?Xa.test(n.css(a,"display"))&&0===a.offsetWidth?Pa(a,Za,function(){return fb(a,b,d)}):fb(a,b,d):void 0},set:function(a,c,d){var e=d&&Ra(a);return db(a,c,d?eb(a,b,d,l.boxSizing&&"border-box"===n.css(a,"boxSizing",!1,e),e):0)}}}),l.opacity||(n.cssHooks.opacity={get:function(a,b){return Wa.test((b&&a.currentStyle?a.currentStyle.filter:a.style.filter)||"")?.01*parseFloat(RegExp.$1)+"":b?"1":""},set:function(a,b){var c=a.style,d=a.currentStyle,e=n.isNumeric(b)?"alpha(opacity="+100*b+")":"",f=d&&d.filter||c.filter||"";c.zoom=1,(b>=1||""===b)&&""===n.trim(f.replace(Va,""))&&c.removeAttribute&&(c.removeAttribute("filter"),""===b||d&&!d.filter)||(c.filter=Va.test(f)?f.replace(Va,e):f+" "+e)}}),n.cssHooks.marginRight=Ua(l.reliableMarginRight,function(a,b){return b?Pa(a,{display:"inline-block"},Sa,[a,"marginRight"]):void 0}),n.cssHooks.marginLeft=Ua(l.reliableMarginLeft,function(a,b){return b?(parseFloat(Sa(a,"marginLeft"))||(n.contains(a.ownerDocument,a)?a.getBoundingClientRect().left-Pa(a,{
marginLeft:0},function(){return a.getBoundingClientRect().left}):0))+"px":void 0}),n.each({margin:"",padding:"",border:"Width"},function(a,b){n.cssHooks[a+b]={expand:function(c){for(var d=0,e={},f="string"==typeof c?c.split(" "):[c];4>d;d++)e[a+V[d]+b]=f[d]||f[d-2]||f[0];return e}},Na.test(a)||(n.cssHooks[a+b].set=db)}),n.fn.extend({css:function(a,b){return Y(this,function(a,b,c){var d,e,f={},g=0;if(n.isArray(b)){for(d=Ra(a),e=b.length;e>g;g++)f[b[g]]=n.css(a,b[g],!1,d);return f}return void 0!==c?n.style(a,b,c):n.css(a,b)},a,b,arguments.length>1)},show:function(){return cb(this,!0)},hide:function(){return cb(this)},toggle:function(a){return"boolean"==typeof a?a?this.show():this.hide():this.each(function(){W(this)?n(this).show():n(this).hide()})}});function gb(a,b,c,d,e){return new gb.prototype.init(a,b,c,d,e)}n.Tween=gb,gb.prototype={constructor:gb,init:function(a,b,c,d,e,f){this.elem=a,this.prop=c,this.easing=e||n.easing._default,this.options=b,this.start=this.now=this.cur(),this.end=d,this.unit=f||(n.cssNumber[c]?"":"px")},cur:function(){var a=gb.propHooks[this.prop];return a&&a.get?a.get(this):gb.propHooks._default.get(this)},run:function(a){var b,c=gb.propHooks[this.prop];return this.options.duration?this.pos=b=n.easing[this.easing](a,this.options.duration*a,0,1,this.options.duration):this.pos=b=a,this.now=(this.end-this.start)*b+this.start,this.options.step&&this.options.step.call(this.elem,this.now,this),c&&c.set?c.set(this):gb.propHooks._default.set(this),this}},gb.prototype.init.prototype=gb.prototype,gb.propHooks={_default:{get:function(a){var b;return 1!==a.elem.nodeType||null!=a.elem[a.prop]&&null==a.elem.style[a.prop]?a.elem[a.prop]:(b=n.css(a.elem,a.prop,""),b&&"auto"!==b?b:0)},set:function(a){n.fx.step[a.prop]?n.fx.step[a.prop](a):1!==a.elem.nodeType||null==a.elem.style[n.cssProps[a.prop]]&&!n.cssHooks[a.prop]?a.elem[a.prop]=a.now:n.style(a.elem,a.prop,a.now+a.unit)}}},gb.propHooks.scrollTop=gb.propHooks.scrollLeft={set:function(a){a.elem.nodeType&&a.elem.parentNode&&(a.elem[a.prop]=a.now)}},n.easing={linear:function(a){return a},swing:function(a){return.5-Math.cos(a*Math.PI)/2},_default:"swing"},n.fx=gb.prototype.init,n.fx.step={};var hb,ib,jb=/^(?:toggle|show|hide)$/,kb=/queueHooks$/;function lb(){return a.setTimeout(function(){hb=void 0}),hb=n.now()}function mb(a,b){var c,d={height:a},e=0;for(b=b?1:0;4>e;e+=2-b)c=V[e],d["margin"+c]=d["padding"+c]=a;return b&&(d.opacity=d.width=a),d}function nb(a,b,c){for(var d,e=(qb.tweeners[b]||[]).concat(qb.tweeners["*"]),f=0,g=e.length;g>f;f++)if(d=e[f].call(c,b,a))return d}function ob(a,b,c){var d,e,f,g,h,i,j,k,m=this,o={},p=a.style,q=a.nodeType&&W(a),r=n._data(a,"fxshow");c.queue||(h=n._queueHooks(a,"fx"),null==h.unqueued&&(h.unqueued=0,i=h.empty.fire,h.empty.fire=function(){h.unqueued||i()}),h.unqueued++,m.always(function(){m.always(function(){h.unqueued--,n.queue(a,"fx").length||h.empty.fire()})})),1===a.nodeType&&("height"in b||"width"in b)&&(c.overflow=[p.overflow,p.overflowX,p.overflowY],j=n.css(a,"display"),k="none"===j?n._data(a,"olddisplay")||Ma(a.nodeName):j,"inline"===k&&"none"===n.css(a,"float")&&(l.inlineBlockNeedsLayout&&"inline"!==Ma(a.nodeName)?p.zoom=1:p.display="inline-block")),c.overflow&&(p.overflow="hidden",l.shrinkWrapBlocks()||m.always(function(){p.overflow=c.overflow[0],p.overflowX=c.overflow[1],p.overflowY=c.overflow[2]}));for(d in b)if(e=b[d],jb.exec(e)){if(delete b[d],f=f||"toggle"===e,e===(q?"hide":"show")){if("show"!==e||!r||void 0===r[d])continue;q=!0}o[d]=r&&r[d]||n.style(a,d)}else j=void 0;if(n.isEmptyObject(o))"inline"===("none"===j?Ma(a.nodeName):j)&&(p.display=j);else{r?"hidden"in r&&(q=r.hidden):r=n._data(a,"fxshow",{}),f&&(r.hidden=!q),q?n(a).show():m.done(function(){n(a).hide()}),m.done(function(){var b;n._removeData(a,"fxshow");for(b in o)n.style(a,b,o[b])});for(d in o)g=nb(q?r[d]:0,d,m),d in r||(r[d]=g.start,q&&(g.end=g.start,g.start="width"===d||"height"===d?1:0))}}function pb(a,b){var c,d,e,f,g;for(c in a)if(d=n.camelCase(c),e=b[d],f=a[c],n.isArray(f)&&(e=f[1],f=a[c]=f[0]),c!==d&&(a[d]=f,delete a[c]),g=n.cssHooks[d],g&&"expand"in g){f=g.expand(f),delete a[d];for(c in f)c in a||(a[c]=f[c],b[c]=e)}else b[d]=e}function qb(a,b,c){var d,e,f=0,g=qb.prefilters.length,h=n.Deferred().always(function(){delete i.elem}),i=function(){if(e)return!1;for(var b=hb||lb(),c=Math.max(0,j.startTime+j.duration-b),d=c/j.duration||0,f=1-d,g=0,i=j.tweens.length;i>g;g++)j.tweens[g].run(f);return h.notifyWith(a,[j,f,c]),1>f&&i?c:(h.resolveWith(a,[j]),!1)},j=h.promise({elem:a,props:n.extend({},b),opts:n.extend(!0,{specialEasing:{},easing:n.easing._default},c),originalProperties:b,originalOptions:c,startTime:hb||lb(),duration:c.duration,tweens:[],createTween:function(b,c){var d=n.Tween(a,j.opts,b,c,j.opts.specialEasing[b]||j.opts.easing);return j.tweens.push(d),d},stop:function(b){var c=0,d=b?j.tweens.length:0;if(e)return this;for(e=!0;d>c;c++)j.tweens[c].run(1);return b?(h.notifyWith(a,[j,1,0]),h.resolveWith(a,[j,b])):h.rejectWith(a,[j,b]),this}}),k=j.props;for(pb(k,j.opts.specialEasing);g>f;f++)if(d=qb.prefilters[f].call(j,a,k,j.opts))return n.isFunction(d.stop)&&(n._queueHooks(j.elem,j.opts.queue).stop=n.proxy(d.stop,d)),d;return n.map(k,nb,j),n.isFunction(j.opts.start)&&j.opts.start.call(a,j),n.fx.timer(n.extend(i,{elem:a,anim:j,queue:j.opts.queue})),j.progress(j.opts.progress).done(j.opts.done,j.opts.complete).fail(j.opts.fail).always(j.opts.always)}n.Animation=n.extend(qb,{tweeners:{"*":[function(a,b){var c=this.createTween(a,b);return X(c.elem,a,U.exec(b),c),c}]},tweener:function(a,b){n.isFunction(a)?(b=a,a=["*"]):a=a.match(G);for(var c,d=0,e=a.length;e>d;d++)c=a[d],qb.tweeners[c]=qb.tweeners[c]||[],qb.tweeners[c].unshift(b)},prefilters:[ob],prefilter:function(a,b){b?qb.prefilters.unshift(a):qb.prefilters.push(a)}}),n.speed=function(a,b,c){var d=a&&"object"==typeof a?n.extend({},a):{complete:c||!c&&b||n.isFunction(a)&&a,duration:a,easing:c&&b||b&&!n.isFunction(b)&&b};return d.duration=n.fx.off?0:"number"==typeof d.duration?d.duration:d.duration in n.fx.speeds?n.fx.speeds[d.duration]:n.fx.speeds._default,null!=d.queue&&d.queue!==!0||(d.queue="fx"),d.old=d.complete,d.complete=function(){n.isFunction(d.old)&&d.old.call(this),d.queue&&n.dequeue(this,d.queue)},d},n.fn.extend({fadeTo:function(a,b,c,d){return this.filter(W).css("opacity",0).show().end().animate({opacity:b},a,c,d)},animate:function(a,b,c,d){var e=n.isEmptyObject(a),f=n.speed(b,c,d),g=function(){var b=qb(this,n.extend({},a),f);(e||n._data(this,"finish"))&&b.stop(!0)};return g.finish=g,e||f.queue===!1?this.each(g):this.queue(f.queue,g)},stop:function(a,b,c){var d=function(a){var b=a.stop;delete a.stop,b(c)};return"string"!=typeof a&&(c=b,b=a,a=void 0),b&&a!==!1&&this.queue(a||"fx",[]),this.each(function(){var b=!0,e=null!=a&&a+"queueHooks",f=n.timers,g=n._data(this);if(e)g[e]&&g[e].stop&&d(g[e]);else for(e in g)g[e]&&g[e].stop&&kb.test(e)&&d(g[e]);for(e=f.length;e--;)f[e].elem!==this||null!=a&&f[e].queue!==a||(f[e].anim.stop(c),b=!1,f.splice(e,1));!b&&c||n.dequeue(this,a)})},finish:function(a){return a!==!1&&(a=a||"fx"),this.each(function(){var b,c=n._data(this),d=c[a+"queue"],e=c[a+"queueHooks"],f=n.timers,g=d?d.length:0;for(c.finish=!0,n.queue(this,a,[]),e&&e.stop&&e.stop.call(this,!0),b=f.length;b--;)f[b].elem===this&&f[b].queue===a&&(f[b].anim.stop(!0),f.splice(b,1));for(b=0;g>b;b++)d[b]&&d[b].finish&&d[b].finish.call(this);delete c.finish})}}),n.each(["toggle","show","hide"],function(a,b){var c=n.fn[b];n.fn[b]=function(a,d,e){return null==a||"boolean"==typeof a?c.apply(this,arguments):this.animate(mb(b,!0),a,d,e)}}),n.each({slideDown:mb("show"),slideUp:mb("hide"),slideToggle:mb("toggle"),fadeIn:{opacity:"show"},fadeOut:{opacity:"hide"},fadeToggle:{opacity:"toggle"}},function(a,b){n.fn[a]=function(a,c,d){return this.animate(b,a,c,d)}}),n.timers=[],n.fx.tick=function(){var a,b=n.timers,c=0;for(hb=n.now();c<b.length;c++)a=b[c],a()||b[c]!==a||b.splice(c--,1);b.length||n.fx.stop(),hb=void 0},n.fx.timer=function(a){n.timers.push(a),a()?n.fx.start():n.timers.pop()},n.fx.interval=13,n.fx.start=function(){ib||(ib=a.setInterval(n.fx.tick,n.fx.interval))},n.fx.stop=function(){a.clearInterval(ib),ib=null},n.fx.speeds={slow:600,fast:200,_default:400},n.fn.delay=function(b,c){return b=n.fx?n.fx.speeds[b]||b:b,c=c||"fx",this.queue(c,function(c,d){var e=a.setTimeout(c,b);d.stop=function(){a.clearTimeout(e)}})},function(){var a,b=d.createElement("input"),c=d.createElement("div"),e=d.createElement("select"),f=e.appendChild(d.createElement("option"));c=d.createElement("div"),c.setAttribute("className","t"),c.innerHTML="  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>",a=c.getElementsByTagName("a")[0],b.setAttribute("type","checkbox"),c.appendChild(b),a=c.getElementsByTagName("a")[0],a.style.cssText="top:1px",l.getSetAttribute="t"!==c.className,l.style=/top/.test(a.getAttribute("style")),l.hrefNormalized="/a"===a.getAttribute("href"),l.checkOn=!!b.value,l.optSelected=f.selected,l.enctype=!!d.createElement("form").enctype,e.disabled=!0,l.optDisabled=!f.disabled,b=d.createElement("input"),b.setAttribute("value",""),l.input=""===b.getAttribute("value"),b.value="t",b.setAttribute("type","radio"),l.radioValue="t"===b.value}();var rb=/\r/g,sb=/[\x20\t\r\n\f]+/g;n.fn.extend({val:function(a){var b,c,d,e=this[0];{if(arguments.length)return d=n.isFunction(a),this.each(function(c){var e;1===this.nodeType&&(e=d?a.call(this,c,n(this).val()):a,null==e?e="":"number"==typeof e?e+="":n.isArray(e)&&(e=n.map(e,function(a){return null==a?"":a+""})),b=n.valHooks[this.type]||n.valHooks[this.nodeName.toLowerCase()],b&&"set"in b&&void 0!==b.set(this,e,"value")||(this.value=e))});if(e)return b=n.valHooks[e.type]||n.valHooks[e.nodeName.toLowerCase()],b&&"get"in b&&void 0!==(c=b.get(e,"value"))?c:(c=e.value,"string"==typeof c?c.replace(rb,""):null==c?"":c)}}}),n.extend({valHooks:{option:{get:function(a){var b=n.find.attr(a,"value");return null!=b?b:n.trim(n.text(a)).replace(sb," ")}},select:{get:function(a){for(var b,c,d=a.options,e=a.selectedIndex,f="select-one"===a.type||0>e,g=f?null:[],h=f?e+1:d.length,i=0>e?h:f?e:0;h>i;i++)if(c=d[i],(c.selected||i===e)&&(l.optDisabled?!c.disabled:null===c.getAttribute("disabled"))&&(!c.parentNode.disabled||!n.nodeName(c.parentNode,"optgroup"))){if(b=n(c).val(),f)return b;g.push(b)}return g},set:function(a,b){var c,d,e=a.options,f=n.makeArray(b),g=e.length;while(g--)if(d=e[g],n.inArray(n.valHooks.option.get(d),f)>-1)try{d.selected=c=!0}catch(h){d.scrollHeight}else d.selected=!1;return c||(a.selectedIndex=-1),e}}}}),n.each(["radio","checkbox"],function(){n.valHooks[this]={set:function(a,b){return n.isArray(b)?a.checked=n.inArray(n(a).val(),b)>-1:void 0}},l.checkOn||(n.valHooks[this].get=function(a){return null===a.getAttribute("value")?"on":a.value})});var tb,ub,vb=n.expr.attrHandle,wb=/^(?:checked|selected)$/i,xb=l.getSetAttribute,yb=l.input;n.fn.extend({attr:function(a,b){return Y(this,n.attr,a,b,arguments.length>1)},removeAttr:function(a){return this.each(function(){n.removeAttr(this,a)})}}),n.extend({attr:function(a,b,c){var d,e,f=a.nodeType;if(3!==f&&8!==f&&2!==f)return"undefined"==typeof a.getAttribute?n.prop(a,b,c):(1===f&&n.isXMLDoc(a)||(b=b.toLowerCase(),e=n.attrHooks[b]||(n.expr.match.bool.test(b)?ub:tb)),void 0!==c?null===c?void n.removeAttr(a,b):e&&"set"in e&&void 0!==(d=e.set(a,c,b))?d:(a.setAttribute(b,c+""),c):e&&"get"in e&&null!==(d=e.get(a,b))?d:(d=n.find.attr(a,b),null==d?void 0:d))},attrHooks:{type:{set:function(a,b){if(!l.radioValue&&"radio"===b&&n.nodeName(a,"input")){var c=a.value;return a.setAttribute("type",b),c&&(a.value=c),b}}}},removeAttr:function(a,b){var c,d,e=0,f=b&&b.match(G);if(f&&1===a.nodeType)while(c=f[e++])d=n.propFix[c]||c,n.expr.match.bool.test(c)?yb&&xb||!wb.test(c)?a[d]=!1:a[n.camelCase("default-"+c)]=a[d]=!1:n.attr(a,c,""),a.removeAttribute(xb?c:d)}}),ub={set:function(a,b,c){return b===!1?n.removeAttr(a,c):yb&&xb||!wb.test(c)?a.setAttribute(!xb&&n.propFix[c]||c,c):a[n.camelCase("default-"+c)]=a[c]=!0,c}},n.each(n.expr.match.bool.source.match(/\w+/g),function(a,b){var c=vb[b]||n.find.attr;yb&&xb||!wb.test(b)?vb[b]=function(a,b,d){var e,f;return d||(f=vb[b],vb[b]=e,e=null!=c(a,b,d)?b.toLowerCase():null,vb[b]=f),e}:vb[b]=function(a,b,c){return c?void 0:a[n.camelCase("default-"+b)]?b.toLowerCase():null}}),yb&&xb||(n.attrHooks.value={set:function(a,b,c){return n.nodeName(a,"input")?void(a.defaultValue=b):tb&&tb.set(a,b,c)}}),xb||(tb={set:function(a,b,c){var d=a.getAttributeNode(c);return d||a.setAttributeNode(d=a.ownerDocument.createAttribute(c)),d.value=b+="","value"===c||b===a.getAttribute(c)?b:void 0}},vb.id=vb.name=vb.coords=function(a,b,c){var d;return c?void 0:(d=a.getAttributeNode(b))&&""!==d.value?d.value:null},n.valHooks.button={get:function(a,b){var c=a.getAttributeNode(b);return c&&c.specified?c.value:void 0},set:tb.set},n.attrHooks.contenteditable={set:function(a,b,c){tb.set(a,""===b?!1:b,c)}},n.each(["width","height"],function(a,b){n.attrHooks[b]={set:function(a,c){return""===c?(a.setAttribute(b,"auto"),c):void 0}}})),l.style||(n.attrHooks.style={get:function(a){return a.style.cssText||void 0},set:function(a,b){return a.style.cssText=b+""}});var zb=/^(?:input|select|textarea|button|object)$/i,Ab=/^(?:a|area)$/i;n.fn.extend({prop:function(a,b){return Y(this,n.prop,a,b,arguments.length>1)},removeProp:function(a){return a=n.propFix[a]||a,this.each(function(){try{this[a]=void 0,delete this[a]}catch(b){}})}}),n.extend({prop:function(a,b,c){var d,e,f=a.nodeType;if(3!==f&&8!==f&&2!==f)return 1===f&&n.isXMLDoc(a)||(b=n.propFix[b]||b,e=n.propHooks[b]),void 0!==c?e&&"set"in e&&void 0!==(d=e.set(a,c,b))?d:a[b]=c:e&&"get"in e&&null!==(d=e.get(a,b))?d:a[b]},propHooks:{tabIndex:{get:function(a){var b=n.find.attr(a,"tabindex");return b?parseInt(b,10):zb.test(a.nodeName)||Ab.test(a.nodeName)&&a.href?0:-1}}},propFix:{"for":"htmlFor","class":"className"}}),l.hrefNormalized||n.each(["href","src"],function(a,b){n.propHooks[b]={get:function(a){return a.getAttribute(b,4)}}}),l.optSelected||(n.propHooks.selected={get:function(a){var b=a.parentNode;return b&&(b.selectedIndex,b.parentNode&&b.parentNode.selectedIndex),null},set:function(a){var b=a.parentNode;b&&(b.selectedIndex,b.parentNode&&b.parentNode.selectedIndex)}}),n.each(["tabIndex","readOnly","maxLength","cellSpacing","cellPadding","rowSpan","colSpan","useMap","frameBorder","contentEditable"],function(){n.propFix[this.toLowerCase()]=this}),l.enctype||(n.propFix.enctype="encoding");var Bb=/[\t\r\n\f]/g;function Cb(a){return n.attr(a,"class")||""}n.fn.extend({addClass:function(a){var b,c,d,e,f,g,h,i=0;if(n.isFunction(a))return this.each(function(b){n(this).addClass(a.call(this,b,Cb(this)))});if("string"==typeof a&&a){b=a.match(G)||[];while(c=this[i++])if(e=Cb(c),d=1===c.nodeType&&(" "+e+" ").replace(Bb," ")){g=0;while(f=b[g++])d.indexOf(" "+f+" ")<0&&(d+=f+" ");h=n.trim(d),e!==h&&n.attr(c,"class",h)}}return this},removeClass:function(a){var b,c,d,e,f,g,h,i=0;if(n.isFunction(a))return this.each(function(b){n(this).removeClass(a.call(this,b,Cb(this)))});if(!arguments.length)return this.attr("class","");if("string"==typeof a&&a){b=a.match(G)||[];while(c=this[i++])if(e=Cb(c),d=1===c.nodeType&&(" "+e+" ").replace(Bb," ")){g=0;while(f=b[g++])while(d.indexOf(" "+f+" ")>-1)d=d.replace(" "+f+" "," ");h=n.trim(d),e!==h&&n.attr(c,"class",h)}}return this},toggleClass:function(a,b){var c=typeof a;return"boolean"==typeof b&&"string"===c?b?this.addClass(a):this.removeClass(a):n.isFunction(a)?this.each(function(c){n(this).toggleClass(a.call(this,c,Cb(this),b),b)}):this.each(function(){var b,d,e,f;if("string"===c){d=0,e=n(this),f=a.match(G)||[];while(b=f[d++])e.hasClass(b)?e.removeClass(b):e.addClass(b)}else void 0!==a&&"boolean"!==c||(b=Cb(this),b&&n._data(this,"__className__",b),n.attr(this,"class",b||a===!1?"":n._data(this,"__className__")||""))})},hasClass:function(a){var b,c,d=0;b=" "+a+" ";while(c=this[d++])if(1===c.nodeType&&(" "+Cb(c)+" ").replace(Bb," ").indexOf(b)>-1)return!0;return!1}}),n.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "),function(a,b){n.fn[b]=function(a,c){return arguments.length>0?this.on(b,null,a,c):this.trigger(b)}}),n.fn.extend({hover:function(a,b){return this.mouseenter(a).mouseleave(b||a)}});var Db=a.location,Eb=n.now(),Fb=/\?/,Gb=/(,)|(\[|{)|(}|])|"(?:[^"\\\r\n]|\\["\\\/bfnrt]|\\u[\da-fA-F]{4})*"\s*:?|true|false|null|-?(?!0\d)\d+(?:\.\d+|)(?:[eE][+-]?\d+|)/g;n.parseJSON=function(b){if(a.JSON&&a.JSON.parse)return a.JSON.parse(b+"");var c,d=null,e=n.trim(b+"");return e&&!n.trim(e.replace(Gb,function(a,b,e,f){return c&&b&&(d=0),0===d?a:(c=e||b,d+=!f-!e,"")}))?Function("return "+e)():n.error("Invalid JSON: "+b)},n.parseXML=function(b){var c,d;if(!b||"string"!=typeof b)return null;try{a.DOMParser?(d=new a.DOMParser,c=d.parseFromString(b,"text/xml")):(c=new a.ActiveXObject("Microsoft.XMLDOM"),c.async="false",c.loadXML(b))}catch(e){c=void 0}return c&&c.documentElement&&!c.getElementsByTagName("parsererror").length||n.error("Invalid XML: "+b),c};var Hb=/#.*$/,Ib=/([?&])_=[^&]*/,Jb=/^(.*?):[ \t]*([^\r\n]*)\r?$/gm,Kb=/^(?:about|app|app-storage|.+-extension|file|res|widget):$/,Lb=/^(?:GET|HEAD)$/,Mb=/^\/\//,Nb=/^([\w.+-]+:)(?:\/\/(?:[^\/?#]*@|)([^\/?#:]*)(?::(\d+)|)|)/,Ob={},Pb={},Qb="*/".concat("*"),Rb=Db.href,Sb=Nb.exec(Rb.toLowerCase())||[];function Tb(a){return function(b,c){"string"!=typeof b&&(c=b,b="*");var d,e=0,f=b.toLowerCase().match(G)||[];if(n.isFunction(c))while(d=f[e++])"+"===d.charAt(0)?(d=d.slice(1)||"*",(a[d]=a[d]||[]).unshift(c)):(a[d]=a[d]||[]).push(c)}}function Ub(a,b,c,d){var e={},f=a===Pb;function g(h){var i;return e[h]=!0,n.each(a[h]||[],function(a,h){var j=h(b,c,d);return"string"!=typeof j||f||e[j]?f?!(i=j):void 0:(b.dataTypes.unshift(j),g(j),!1)}),i}return g(b.dataTypes[0])||!e["*"]&&g("*")}function Vb(a,b){var c,d,e=n.ajaxSettings.flatOptions||{};for(d in b)void 0!==b[d]&&((e[d]?a:c||(c={}))[d]=b[d]);return c&&n.extend(!0,a,c),a}function Wb(a,b,c){var d,e,f,g,h=a.contents,i=a.dataTypes;while("*"===i[0])i.shift(),void 0===e&&(e=a.mimeType||b.getResponseHeader("Content-Type"));if(e)for(g in h)if(h[g]&&h[g].test(e)){i.unshift(g);break}if(i[0]in c)f=i[0];else{for(g in c){if(!i[0]||a.converters[g+" "+i[0]]){f=g;break}d||(d=g)}f=f||d}return f?(f!==i[0]&&i.unshift(f),c[f]):void 0}function Xb(a,b,c,d){var e,f,g,h,i,j={},k=a.dataTypes.slice();if(k[1])for(g in a.converters)j[g.toLowerCase()]=a.converters[g];f=k.shift();while(f)if(a.responseFields[f]&&(c[a.responseFields[f]]=b),!i&&d&&a.dataFilter&&(b=a.dataFilter(b,a.dataType)),i=f,f=k.shift())if("*"===f)f=i;else if("*"!==i&&i!==f){if(g=j[i+" "+f]||j["* "+f],!g)for(e in j)if(h=e.split(" "),h[1]===f&&(g=j[i+" "+h[0]]||j["* "+h[0]])){g===!0?g=j[e]:j[e]!==!0&&(f=h[0],k.unshift(h[1]));break}if(g!==!0)if(g&&a["throws"])b=g(b);else try{b=g(b)}catch(l){return{state:"parsererror",error:g?l:"No conversion from "+i+" to "+f}}}return{state:"success",data:b}}n.extend({active:0,lastModified:{},etag:{},ajaxSettings:{url:Rb,type:"GET",isLocal:Kb.test(Sb[1]),global:!0,processData:!0,async:!0,contentType:"application/x-www-form-urlencoded; charset=UTF-8",accepts:{"*":Qb,text:"text/plain",html:"text/html",xml:"application/xml, text/xml",json:"application/json, text/javascript"},contents:{xml:/\bxml\b/,html:/\bhtml/,json:/\bjson\b/},responseFields:{xml:"responseXML",text:"responseText",json:"responseJSON"},converters:{"* text":String,"text html":!0,"text json":n.parseJSON,"text xml":n.parseXML},flatOptions:{url:!0,context:!0}},ajaxSetup:function(a,b){return b?Vb(Vb(a,n.ajaxSettings),b):Vb(n.ajaxSettings,a)},ajaxPrefilter:Tb(Ob),ajaxTransport:Tb(Pb),ajax:function(b,c){"object"==typeof b&&(c=b,b=void 0),c=c||{};var d,e,f,g,h,i,j,k,l=n.ajaxSetup({},c),m=l.context||l,o=l.context&&(m.nodeType||m.jquery)?n(m):n.event,p=n.Deferred(),q=n.Callbacks("once memory"),r=l.statusCode||{},s={},t={},u=0,v="canceled",w={readyState:0,getResponseHeader:function(a){var b;if(2===u){if(!k){k={};while(b=Jb.exec(g))k[b[1].toLowerCase()]=b[2]}b=k[a.toLowerCase()]}return null==b?null:b},getAllResponseHeaders:function(){return 2===u?g:null},setRequestHeader:function(a,b){var c=a.toLowerCase();return u||(a=t[c]=t[c]||a,s[a]=b),this},overrideMimeType:function(a){return u||(l.mimeType=a),this},statusCode:function(a){var b;if(a)if(2>u)for(b in a)r[b]=[r[b],a[b]];else w.always(a[w.status]);return this},abort:function(a){var b=a||v;return j&&j.abort(b),y(0,b),this}};if(p.promise(w).complete=q.add,w.success=w.done,w.error=w.fail,l.url=((b||l.url||Rb)+"").replace(Hb,"").replace(Mb,Sb[1]+"//"),l.type=c.method||c.type||l.method||l.type,l.dataTypes=n.trim(l.dataType||"*").toLowerCase().match(G)||[""],null==l.crossDomain&&(d=Nb.exec(l.url.toLowerCase()),l.crossDomain=!(!d||d[1]===Sb[1]&&d[2]===Sb[2]&&(d[3]||("http:"===d[1]?"80":"443"))===(Sb[3]||("http:"===Sb[1]?"80":"443")))),l.data&&l.processData&&"string"!=typeof l.data&&(l.data=n.param(l.data,l.traditional)),Ub(Ob,l,c,w),2===u)return w;i=n.event&&l.global,i&&0===n.active++&&n.event.trigger("ajaxStart"),l.type=l.type.toUpperCase(),l.hasContent=!Lb.test(l.type),f=l.url,l.hasContent||(l.data&&(f=l.url+=(Fb.test(f)?"&":"?")+l.data,delete l.data),l.cache===!1&&(l.url=Ib.test(f)?f.replace(Ib,"$1_="+Eb++):f+(Fb.test(f)?"&":"?")+"_="+Eb++)),l.ifModified&&(n.lastModified[f]&&w.setRequestHeader("If-Modified-Since",n.lastModified[f]),n.etag[f]&&w.setRequestHeader("If-None-Match",n.etag[f])),(l.data&&l.hasContent&&l.contentType!==!1||c.contentType)&&w.setRequestHeader("Content-Type",l.contentType),w.setRequestHeader("Accept",l.dataTypes[0]&&l.accepts[l.dataTypes[0]]?l.accepts[l.dataTypes[0]]+("*"!==l.dataTypes[0]?", "+Qb+"; q=0.01":""):l.accepts["*"]);for(e in l.headers)w.setRequestHeader(e,l.headers[e]);if(l.beforeSend&&(l.beforeSend.call(m,w,l)===!1||2===u))return w.abort();v="abort";for(e in{success:1,error:1,complete:1})w[e](l[e]);if(j=Ub(Pb,l,c,w)){if(w.readyState=1,i&&o.trigger("ajaxSend",[w,l]),2===u)return w;l.async&&l.timeout>0&&(h=a.setTimeout(function(){w.abort("timeout")},l.timeout));try{u=1,j.send(s,y)}catch(x){if(!(2>u))throw x;y(-1,x)}}else y(-1,"No Transport");function y(b,c,d,e){var k,s,t,v,x,y=c;2!==u&&(u=2,h&&a.clearTimeout(h),j=void 0,g=e||"",w.readyState=b>0?4:0,k=b>=200&&300>b||304===b,d&&(v=Wb(l,w,d)),v=Xb(l,v,w,k),k?(l.ifModified&&(x=w.getResponseHeader("Last-Modified"),x&&(n.lastModified[f]=x),x=w.getResponseHeader("etag"),x&&(n.etag[f]=x)),204===b||"HEAD"===l.type?y="nocontent":304===b?y="notmodified":(y=v.state,s=v.data,t=v.error,k=!t)):(t=y,!b&&y||(y="error",0>b&&(b=0))),w.status=b,w.statusText=(c||y)+"",k?p.resolveWith(m,[s,y,w]):p.rejectWith(m,[w,y,t]),w.statusCode(r),r=void 0,i&&o.trigger(k?"ajaxSuccess":"ajaxError",[w,l,k?s:t]),q.fireWith(m,[w,y]),i&&(o.trigger("ajaxComplete",[w,l]),--n.active||n.event.trigger("ajaxStop")))}return w},getJSON:function(a,b,c){return n.get(a,b,c,"json")},getScript:function(a,b){return n.get(a,void 0,b,"script")}}),n.each(["get","post"],function(a,b){n[b]=function(a,c,d,e){return n.isFunction(c)&&(e=e||d,d=c,c=void 0),n.ajax(n.extend({url:a,type:b,dataType:e,data:c,success:d},n.isPlainObject(a)&&a))}}),n._evalUrl=function(a){return n.ajax({url:a,type:"GET",dataType:"script",cache:!0,async:!1,global:!1,"throws":!0})},n.fn.extend({wrapAll:function(a){if(n.isFunction(a))return this.each(function(b){n(this).wrapAll(a.call(this,b))});if(this[0]){var b=n(a,this[0].ownerDocument).eq(0).clone(!0);this[0].parentNode&&b.insertBefore(this[0]),b.map(function(){var a=this;while(a.firstChild&&1===a.firstChild.nodeType)a=a.firstChild;return a}).append(this)}return this},wrapInner:function(a){return n.isFunction(a)?this.each(function(b){n(this).wrapInner(a.call(this,b))}):this.each(function(){var b=n(this),c=b.contents();c.length?c.wrapAll(a):b.append(a)})},wrap:function(a){var b=n.isFunction(a);return this.each(function(c){n(this).wrapAll(b?a.call(this,c):a)})},unwrap:function(){return this.parent().each(function(){n.nodeName(this,"body")||n(this).replaceWith(this.childNodes)}).end()}});function Yb(a){return a.style&&a.style.display||n.css(a,"display")}function Zb(a){if(!n.contains(a.ownerDocument||d,a))return!0;while(a&&1===a.nodeType){if("none"===Yb(a)||"hidden"===a.type)return!0;a=a.parentNode}return!1}n.expr.filters.hidden=function(a){return l.reliableHiddenOffsets()?a.offsetWidth<=0&&a.offsetHeight<=0&&!a.getClientRects().length:Zb(a)},n.expr.filters.visible=function(a){return!n.expr.filters.hidden(a)};var $b=/%20/g,_b=/\[\]$/,ac=/\r?\n/g,bc=/^(?:submit|button|image|reset|file)$/i,cc=/^(?:input|select|textarea|keygen)/i;function dc(a,b,c,d){var e;if(n.isArray(b))n.each(b,function(b,e){c||_b.test(a)?d(a,e):dc(a+"["+("object"==typeof e&&null!=e?b:"")+"]",e,c,d)});else if(c||"object"!==n.type(b))d(a,b);else for(e in b)dc(a+"["+e+"]",b[e],c,d)}n.param=function(a,b){var c,d=[],e=function(a,b){b=n.isFunction(b)?b():null==b?"":b,d[d.length]=encodeURIComponent(a)+"="+encodeURIComponent(b)};if(void 0===b&&(b=n.ajaxSettings&&n.ajaxSettings.traditional),n.isArray(a)||a.jquery&&!n.isPlainObject(a))n.each(a,function(){e(this.name,this.value)});else for(c in a)dc(c,a[c],b,e);return d.join("&").replace($b,"+")},n.fn.extend({serialize:function(){return n.param(this.serializeArray())},serializeArray:function(){return this.map(function(){var a=n.prop(this,"elements");return a?n.makeArray(a):this}).filter(function(){var a=this.type;return this.name&&!n(this).is(":disabled")&&cc.test(this.nodeName)&&!bc.test(a)&&(this.checked||!Z.test(a))}).map(function(a,b){var c=n(this).val();return null==c?null:n.isArray(c)?n.map(c,function(a){return{name:b.name,value:a.replace(ac,"\r\n")}}):{name:b.name,value:c.replace(ac,"\r\n")}}).get()}}),n.ajaxSettings.xhr=void 0!==a.ActiveXObject?function(){return this.isLocal?ic():d.documentMode>8?hc():/^(get|post|head|put|delete|options)$/i.test(this.type)&&hc()||ic()}:hc;var ec=0,fc={},gc=n.ajaxSettings.xhr();a.attachEvent&&a.attachEvent("onunload",function(){for(var a in fc)fc[a](void 0,!0)}),l.cors=!!gc&&"withCredentials"in gc,gc=l.ajax=!!gc,gc&&n.ajaxTransport(function(b){if(!b.crossDomain||l.cors){var c;return{send:function(d,e){var f,g=b.xhr(),h=++ec;if(g.open(b.type,b.url,b.async,b.username,b.password),b.xhrFields)for(f in b.xhrFields)g[f]=b.xhrFields[f];b.mimeType&&g.overrideMimeType&&g.overrideMimeType(b.mimeType),b.crossDomain||d["X-Requested-With"]||(d["X-Requested-With"]="XMLHttpRequest");for(f in d)void 0!==d[f]&&g.setRequestHeader(f,d[f]+"");g.send(b.hasContent&&b.data||null),c=function(a,d){var f,i,j;if(c&&(d||4===g.readyState))if(delete fc[h],c=void 0,g.onreadystatechange=n.noop,d)4!==g.readyState&&g.abort();else{j={},f=g.status,"string"==typeof g.responseText&&(j.text=g.responseText);try{i=g.statusText}catch(k){i=""}f||!b.isLocal||b.crossDomain?1223===f&&(f=204):f=j.text?200:404}j&&e(f,i,j,g.getAllResponseHeaders())},b.async?4===g.readyState?a.setTimeout(c):g.onreadystatechange=fc[h]=c:c()},abort:function(){c&&c(void 0,!0)}}}});function hc(){try{return new a.XMLHttpRequest}catch(b){}}function ic(){try{return new a.ActiveXObject("Microsoft.XMLHTTP")}catch(b){}}n.ajaxSetup({accepts:{script:"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"},contents:{script:/\b(?:java|ecma)script\b/},converters:{"text script":function(a){return n.globalEval(a),a}}}),n.ajaxPrefilter("script",function(a){void 0===a.cache&&(a.cache=!1),a.crossDomain&&(a.type="GET",a.global=!1)}),n.ajaxTransport("script",function(a){if(a.crossDomain){var b,c=d.head||n("head")[0]||d.documentElement;return{send:function(e,f){b=d.createElement("script"),b.async=!0,a.scriptCharset&&(b.charset=a.scriptCharset),b.src=a.url,b.onload=b.onreadystatechange=function(a,c){(c||!b.readyState||/loaded|complete/.test(b.readyState))&&(b.onload=b.onreadystatechange=null,b.parentNode&&b.parentNode.removeChild(b),b=null,c||f(200,"success"))},c.insertBefore(b,c.firstChild)},abort:function(){b&&b.onload(void 0,!0)}}}});var jc=[],kc=/(=)\?(?=&|$)|\?\?/;n.ajaxSetup({jsonp:"callback",jsonpCallback:function(){var a=jc.pop()||n.expando+"_"+Eb++;return this[a]=!0,a}}),n.ajaxPrefilter("json jsonp",function(b,c,d){var e,f,g,h=b.jsonp!==!1&&(kc.test(b.url)?"url":"string"==typeof b.data&&0===(b.contentType||"").indexOf("application/x-www-form-urlencoded")&&kc.test(b.data)&&"data");return h||"jsonp"===b.dataTypes[0]?(e=b.jsonpCallback=n.isFunction(b.jsonpCallback)?b.jsonpCallback():b.jsonpCallback,h?b[h]=b[h].replace(kc,"$1"+e):b.jsonp!==!1&&(b.url+=(Fb.test(b.url)?"&":"?")+b.jsonp+"="+e),b.converters["script json"]=function(){return g||n.error(e+" was not called"),g[0]},b.dataTypes[0]="json",f=a[e],a[e]=function(){g=arguments},d.always(function(){void 0===f?n(a).removeProp(e):a[e]=f,b[e]&&(b.jsonpCallback=c.jsonpCallback,jc.push(e)),g&&n.isFunction(f)&&f(g[0]),g=f=void 0}),"script"):void 0}),n.parseHTML=function(a,b,c){if(!a||"string"!=typeof a)return null;"boolean"==typeof b&&(c=b,b=!1),b=b||d;var e=x.exec(a),f=!c&&[];return e?[b.createElement(e[1])]:(e=ja([a],b,f),f&&f.length&&n(f).remove(),n.merge([],e.childNodes))};var lc=n.fn.load;n.fn.load=function(a,b,c){if("string"!=typeof a&&lc)return lc.apply(this,arguments);var d,e,f,g=this,h=a.indexOf(" ");return h>-1&&(d=n.trim(a.slice(h,a.length)),a=a.slice(0,h)),n.isFunction(b)?(c=b,b=void 0):b&&"object"==typeof b&&(e="POST"),g.length>0&&n.ajax({url:a,type:e||"GET",dataType:"html",data:b}).done(function(a){f=arguments,g.html(d?n("<div>").append(n.parseHTML(a)).find(d):a)}).always(c&&function(a,b){g.each(function(){c.apply(this,f||[a.responseText,b,a])})}),this},n.each(["ajaxStart","ajaxStop","ajaxComplete","ajaxError","ajaxSuccess","ajaxSend"],function(a,b){n.fn[b]=function(a){return this.on(b,a)}}),n.expr.filters.animated=function(a){return n.grep(n.timers,function(b){return a===b.elem}).length};function mc(a){return n.isWindow(a)?a:9===a.nodeType?a.defaultView||a.parentWindow:!1}n.offset={setOffset:function(a,b,c){var d,e,f,g,h,i,j,k=n.css(a,"position"),l=n(a),m={};"static"===k&&(a.style.position="relative"),h=l.offset(),f=n.css(a,"top"),i=n.css(a,"left"),j=("absolute"===k||"fixed"===k)&&n.inArray("auto",[f,i])>-1,j?(d=l.position(),g=d.top,e=d.left):(g=parseFloat(f)||0,e=parseFloat(i)||0),n.isFunction(b)&&(b=b.call(a,c,n.extend({},h))),null!=b.top&&(m.top=b.top-h.top+g),null!=b.left&&(m.left=b.left-h.left+e),"using"in b?b.using.call(a,m):l.css(m)}},n.fn.extend({offset:function(a){if(arguments.length)return void 0===a?this:this.each(function(b){n.offset.setOffset(this,a,b)});var b,c,d={top:0,left:0},e=this[0],f=e&&e.ownerDocument;if(f)return b=f.documentElement,n.contains(b,e)?("undefined"!=typeof e.getBoundingClientRect&&(d=e.getBoundingClientRect()),c=mc(f),{top:d.top+(c.pageYOffset||b.scrollTop)-(b.clientTop||0),left:d.left+(c.pageXOffset||b.scrollLeft)-(b.clientLeft||0)}):d},position:function(){if(this[0]){var a,b,c={top:0,left:0},d=this[0];return"fixed"===n.css(d,"position")?b=d.getBoundingClientRect():(a=this.offsetParent(),b=this.offset(),n.nodeName(a[0],"html")||(c=a.offset()),c.top+=n.css(a[0],"borderTopWidth",!0),c.left+=n.css(a[0],"borderLeftWidth",!0)),{top:b.top-c.top-n.css(d,"marginTop",!0),left:b.left-c.left-n.css(d,"marginLeft",!0)}}},offsetParent:function(){return this.map(function(){var a=this.offsetParent;while(a&&!n.nodeName(a,"html")&&"static"===n.css(a,"position"))a=a.offsetParent;return a||Qa})}}),n.each({scrollLeft:"pageXOffset",scrollTop:"pageYOffset"},function(a,b){var c=/Y/.test(b);n.fn[a]=function(d){return Y(this,function(a,d,e){var f=mc(a);return void 0===e?f?b in f?f[b]:f.document.documentElement[d]:a[d]:void(f?f.scrollTo(c?n(f).scrollLeft():e,c?e:n(f).scrollTop()):a[d]=e)},a,d,arguments.length,null)}}),n.each(["top","left"],function(a,b){n.cssHooks[b]=Ua(l.pixelPosition,function(a,c){return c?(c=Sa(a,b),Oa.test(c)?n(a).position()[b]+"px":c):void 0})}),n.each({Height:"height",Width:"width"},function(a,b){n.each({
padding:"inner"+a,content:b,"":"outer"+a},function(c,d){n.fn[d]=function(d,e){var f=arguments.length&&(c||"boolean"!=typeof d),g=c||(d===!0||e===!0?"margin":"border");return Y(this,function(b,c,d){var e;return n.isWindow(b)?b.document.documentElement["client"+a]:9===b.nodeType?(e=b.documentElement,Math.max(b.body["scroll"+a],e["scroll"+a],b.body["offset"+a],e["offset"+a],e["client"+a])):void 0===d?n.css(b,c,g):n.style(b,c,d,g)},b,f?d:void 0,f,null)}})}),n.fn.extend({bind:function(a,b,c){return this.on(a,null,b,c)},unbind:function(a,b){return this.off(a,null,b)},delegate:function(a,b,c,d){return this.on(b,a,c,d)},undelegate:function(a,b,c){return 1===arguments.length?this.off(a,"**"):this.off(b,a||"**",c)}}),n.fn.size=function(){return this.length},n.fn.andSelf=n.fn.addBack,"function"==typeof define&&define.amd&&define("jquery",[],function(){return n});var nc=a.jQuery,oc=a.$;return n.noConflict=function(b){return a.$===n&&(a.$=oc),b&&a.jQuery===n&&(a.jQuery=nc),n},b||(a.jQuery=a.$=n),n});  ~  8   �� E A S T E R E G G . J S         0           /*
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2009-2023, Peter Johnson (gravatar.com/delphidabbler).
 *
 * JavaScript code used to perform animations in program's easter egg.
 * Requires jQuery and lite version of jQuery Cycle plug-in.
 */


// Main function called when DOM has loaded. Runs prelinary animations up to
// when introductory page is shown on unfolded screen
$(document).ready(function(){
  
  //! Fix vulnerability using patch suggested in dependabot alert
  //! https://github.com/delphidabbler/codesnip/security/dependabot/1 
  jQuery.htmlPrefilter = function( html ) {
    return html;
  };

  var spt = null;  // showPrompt timeout

  $("#screen-top").click(function(){
    // screen top click => open screen
    // prevent or stop any prompt animations
    if ( spt != null )
      clearTimeout(spt);
    stopPrompt();
    // disable click on screen top: this is a one time only event
    $("#screen-top").off();
    $("#screen-top").css("cursor", "default");
    // unfolds out the screen: moves top and middle elements simultaneously,
    // then displays intro page on unfolded screen
    $("#screen-middle").animate({top: 48, height: 304}, 2000);
    $("#screen-top").animate(
      {top: 26},
      2000,
      '',
      function() {
        showIntro();
        showCancelButton();
      }
    );
  });
  //
  // show a prompt if user doesn't click anything in specified time
  spt = setTimeout(showPrompt, 3500);
});

// Display introductory page on unfloded screen, along with slideshow start
// button.
function showIntro() {
  var pulse = 150;

  setRollover("#start", "play-btn.png", "play-btn-hover.png");
  $("#start").click(function() {
    // Start button clicked:
    // disable further clicks: this is a one-time action
    $("#start").off();
    // switch of title text in pop-up window
    $("#start").attr("title", "");
    $("#start").css("cursor", "default");
    // fade out intro text and start slide show
    $("#intro").fadeOut(500, slideShow);
  });
  $("#intro").fadeIn(1200);
}

// Prepare and display cancel button in unfolded screen
function showCancelButton() {
  setRollover("#cancel-btn", "cancel-btn.png", "cancel-btn-hover.png");
  $("#cancel-btn").click(function() {
    // clear events and switch of title (may be popped up)
    $(this).off();
    $(this).attr("title", "");
    // return true to allow event to bubble up to dialogue box to permit it to
    // close
    return true;
  });
  $("#cancel-btn").fadeIn(1200);
}

// Runs slide show
function slideShow() {
  $("#slideshow").fadeIn(1000).cycle({
    fx: "fade",
    timeout: 4000,
    speed: 2500
  });
}

// Runs prompt animation telling user where to click to display content
function showPrompt() {
  var text = $("#click-prompt");
  var arrow = $("#click-arrow");
  var jigHi = 245;
  var jigLo = 265;
  var jigTime = 150;
  // display arrow pointing at screen top and jiggle it, then display promt
  // text
  arrow.css("top", jigLo);
  arrow
    .fadeIn(200)
    // first jiggle
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .delay(1500)
    // second jiggle
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .animate({top: jigHi}, jigTime)
    .animate({top: jigLo}, jigTime)
    .animate({top: jigHi}, jigTime)
    .animate(
      {top: jigLo},
      jigTime,
      function(){
        // show prompt text above arrow
        text.css(
          "top",
          parseInt(arrow.css("top")) - parseInt(text.css("height")) - 6
        );
        text.delay(1000).fadeIn(1000);
      }
    );
}

// Stops any running prompt animation and hides related elements
function stopPrompt() {
  $("#click-prompt").stop();
  $("#click-arrow").stop();
  $("#click-prompt").hide();
  $("#click-arrow").hide();
  // following is required to stop arrow from appearing when screen is
  // expanding: don't understand why this happens
  $("#click-arrow").css("width", "0");
}

// Sets rollover images for elements matching given CSS selector.
function setRollover(selector, normalImg, hoverImg) {
  $(selector).on(
    "mouseout",
    function () {
      $(this).attr("src", normalImg);
    }
  );
  $(selector).on(
    "mousemove",
    function () {
      $(this).attr("src", hoverImg);
    }
  );
}

  :	  4   �� E X T E R N A L . J S       0           /*
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2006-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * JavaScript code used call into host application via external object. All
 * HTML and JavaScript code should call these routines rather than making
 * direct calls to the external object.
 */


/*
 * Calls external object to get host application to display Configure Compilers
 * dialog box.
 *  @return False.
 */
function configCompilers() {
  external.ConfigCompilers();
  return false;
}

/*
 * Calls external object to get host application to display Update Database
 * dialog box.
 *  @return False.
 */
function updateDbase() {
  external.UpdateDbase();
  return false;
}

/*
 * Calls external object to get host application to display a named snippet.
 *  @param string snippet [in] Name of snippet to be displayed.
 *  @param boolean userdefined [in] Whether snippet is user defined.
 *  @return False.
 */
function displaySnippet(snippet, userdefined) {
  var e = window.event;
  external.DisplaySnippet(snippet, userdefined, e.ctrlKey);
  return false;
}

/*
 * Calls external object to get host application to display a category.
 *  @param string catid [in] ID of category to be displayed.
 *  @return False.
 */
function displayCategory(catid) {
  var e = window.event;
  external.DisplayCategory(catid, e.ctrlKey);
  return false;
}

/*
 * Calls external object to get host application to edit a named snippet.
 *  @param string snippet [in] Name of snippet to be edited. Must be user
 *    defined.
 *  @return False.
 */
function editSnippet(snippet) {
  external.EditSnippet(snippet);
  return false;
}

/*
 * Calls external object to get host application to start Snippets Editor ready
 * for a new snippet to be entered.
 *  @return False.
 */
function newSnippet() {
  external.NewSnippet();
  return false;
}

/*
 * Calls external object to get host application to display the CodeSnip news
 * blog.
 *  @return False.
 */
function showNews() {
  external.ShowNews();
  return false;
}

/*
 * Calls external object to get host application to display About box.
 *  @return False,
 */
function showAboutBox() {
  external.ShowAboutBox();
  return false;
}
  1  <   �� O V E R F L O W X F I X . J S       0           /*
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2013-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * JavaScript code used fix the overflow "auto" display bug in Internet
 * explorer where specifying "auto" as the value of the overflow-x CSS property
 * causes an unexpected vertical scroll bar to be displayed whenever the
 * horizontal scroll bar is displayed.
 */

(function () {
    var elemsToFix;

    function initElems() {
        var sourceCodeParent;
        var compileResultsElem;
        var elemProps;
        var i;
        sourceCodeParent = document.getElementById('sourcecode');
        if (sourceCodeParent)
            elemProps = getElementsByClass('pas-source', sourceCodeParent);
        else
            elemProps = [];
        compileResultsElem = document.getElementById('compile-results');
        if (compileResultsElem)
            elemProps.push(compileResultsElem);
        elemsToFix = [];
        for (i = 0; i < elemProps.length; i += 1) {
            elemsToFix.push({
                props: elemProps[i],
                oldPaddingBottom: elemProps[i].style['paddingBottom']
            });
        }
    }

    // Modification of function by Dustin Diaz
    function getElementsByClass(searchClass,node,tag) {
        var classElements = [];
        if (node == null) {
            node = document;
        }
        if (tag == null) {
            tag = '*';
        }
        var els = node.getElementsByTagName(tag);
        var elsLen = els.length;
        var pattern = new RegExp("(^|\\s)" + searchClass + "(\\s|$)");
        var i = 0, j = 0;
        while (i < elsLen) {
            if ( pattern.test(els[i].className) ) {
                classElements[j] = els[i];
                j += 1;
            }
            i += 1;
        }
        return classElements;
    }

    // Derived from Remy Sharp's code:
    //   https://remysharp.com/2008/01/21/fixing-ie-overflow-problem/
    function fixOverflow(elems) {
        var i;
        for (i = 0; i < elems.length; i += 1) {
            // if the scrollWidth (the real width) is greater than the visible
            // width, then apply style changes
            if (elems[i].props.scrollWidth > elems[i].props.offsetWidth) {
                elems[i].props.style['paddingBottom'] = '18px';
                elems[i].props.style['overflowY'] = 'hidden';
            } else {
                elems[i].props.style['paddingBottom'] =
                    elems[i].oldPaddingBottom;
            }
        }
    }

    window.onload = function () {
        initElems();
        fixOverflow(elemsToFix);
    };

    window.onresize = function () {
        fixOverflow(elemsToFix);
    };

}());   