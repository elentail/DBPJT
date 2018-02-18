import pymysql
import re,sys

sqlfile = 'sample.sql'
conn = pymysql.Connection(host='localhost',user='root',password='elfjjang',db='testdb')
curs = conn.cursor()
ignorestatement = False # by default each time we get a ';' that's our cue to execute.
statement = ""
for line in open(sqlfile):
    if line.startswith('DELIMITER'):
        if not ignorestatement:
            ignorestatement = True # disable executing when we get a ';'
            continue
        else:
            ignorestatement = False # re-enable execution of sql queries on ';'
            line = " ;" # Rewrite the DELIMITER command to allow the block of sql to execute
    if re.match(r'--', line):  # ignore sql comment lines
        continue
    if not re.search(r'[^-;]+;', line) or ignorestatement:  # keep appending lines that don't end in ';' or DELIMITER has been called
        statement = statement + line
    else:  # when you get a line ending in ';' then exec statement and reset for next statement providing the DELIMITER hasn't been set
        statement = statement + line
        # print "\n\n[DEBUG] Executing SQL statement:\n%s" % (statement)
        try:
            curs.execute(statement)
            conn.commit()
            statement = ""
        except curs.Error as e:
            print(sqlfile + " - Error applying (" + str(e) + ")\nTerminating.")
            sys.exit(1)
