
<!-- TWO STEPS TO INSTALL VALIDATE DATE:

  1.  Copy the coding into the HEAD of your HTML document
  2.  Add the last code into the BODY of your HTML document  -->

<!-- STEP ONE: Paste this code into the HEAD of your HTML document  -->

<HEAD>

<SCRIPT LANGUAGE="JavaScript">

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->
<!-- Original:  Torsten Frey (tf@tfrey.de) -->
<!-- Web Site:  http://www.tfrey.de -->

<!-- Begin
	function check_date(field){
		var checkstr = "0123456789";
		var DateField = field;
		var Datevalue = "";
		var DateTemp = "";
		var seperator = ".";
		var day;
		var month;
		var year;
		var leap = 0;
		var err = 0;
		var i;
		DateValue = DateField.value;
		/* Delete all chars except 0..9 */
		for (i = 0; i < DateValue.length; i++) {
			if (checkstr.indexOf(DateValue.substr(i,1)) >= 0) {
				DateTemp = DateTemp + DateValue.substr(i,1);
			}
		}
		DateValue = DateTemp;
		/* Always change date to 8 digits - string*/
		/* if year is entered as 2-digit / always assume 20xx */
		if (DateValue.length == 6) {
			DateValue = DateValue.substr(0,4) + '20' + DateValue.substr(4,2); }
		if (DateValue.length != 8) {
				err = 19;}
		/* year is wrong if year = 0000 */
		year = DateValue.substr(4,4);
		if (year == 0) {
			err = 20;
		}
		/* Validation of month*/
		month = DateValue.substr(2,2);
		if ((month < 1) || (month > 12)) {
			err = 21;
		}
		/* Validation of day*/
		day = DateValue.substr(0,2);
		if (day < 1) {
			err = 22;
		}
		/* Validation leap-year / february / day */
		if ((year % 4 == 0) || (year % 100 == 0) || (year % 400 == 0)) {
			leap = 1;
		}
		if ((month == 2) && (leap == 1) && (day > 29)) {
			err = 23;
		}
		if ((month == 2) && (leap != 1) && (day > 28)) {
			err = 24;
		}
		/* Validation of other months */
		if ((day > 31) && ((month == "01") || (month == "03") || (month == "05") || (month == "07") || (month == "08") || (month == "10") || (month == "12"))) {
			err = 25;
		}
		if ((day > 30) && ((month == "04") || (month == "06") || (month == "09") || (month == "11"))) {
			err = 26;
		}
		/* if 00 ist entered, no error, deleting the entry */
		if ((day == 0) && (month == 0) && (year == 00)) {
			err = 0; day = ""; month = ""; year = ""; seperator = "";
		}
		/* if no error, write the completed date to Input-Field (e.g. 13.12.2001) */
		if (err == 0) {
			DateField.value = day + seperator + month + seperator + year;
		}
		/* Error-message if err != 0 */
		else {
			alert("Date is incorrect!");
			DateField.select();
			DateField.focus();
		}
}
//  End -->
//  </script>
//
//  </HEAD>
//
//  <!-- STEP TWO: Copy this code into the BODY of your HTML document  -->
//
//  <BODY>
//
//  <CENTER>
//  <FORM name="datecheck">
//  <TABLE border="0" width="60%">
//      <TR>
//        	<TD>
//        	Enter Date (Use European format shown at right)<P>
//        		<INPUT type="text" name=testdat size='10' maxlength="10" onblur="check_date(this)">
//        			<INPUT type= "submit" name="button" value="Press to Validate"><p>
//        				(Date is validated after leaving the field.)
//        				</TD>
//        				<TD>
//        					<b>ddmmyy</b> (171201)   or <BR>
//        						<b>ddmmyyyy</b> (17122001) or <BR>
//        							<b>ddXmmXyy</b> (17-12-01 or 17y12q01 ... ) or <BR>
//        								<b>ddXmmXyyyy</b> (17.12.2001 or 17,12,2001 ...) <br>
//        									where "X" is any sign not in 0..9, i.e. "-" or "/"<p>
//        										</TD>
//        										</TR>
//        										</TABLE>
//        										</FORM>
//        										</CENTER>
//
//
//        										<p><center>
//        										<font face="arial, helvetica" size"-2">Free JavaScripts provided<br>
//        										by <a href="http://javascriptsource.com">The JavaScript Source</a></font>
//        										</center><p>
//
//        										<!-- Script Size:  3.77 KB -->
