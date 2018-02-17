#!/usr/bin/env python

import re,sys
import pymysql

db_info = {
        'host':'127.0.0.1',\
        'user':'root',\
        'password':'elfjjang',\
        'db':'testdb',\
        'charset':'utf8',\
        'cursorclass':pymysql.cursors.DictCursor
        }
"""
1 _print_building print all bulidings
2 _print_performance print all performances
3 _print_audience print all audience
4 _insert_building insert a new bulding
5 _remove_building remove a building
6 _insert_performance insert a new performance
7 _remove_performance remove a performance
8 _insert_audience insert a new audience
9 _remove_audience remove an audience
10 _assign_performance assign a performance to a building
11 _book_performance book a performance
12 _print_building_assign print all performances wich assigned at a building
13 _print_audience_perform audiences who booked for a performance
14 _print_ticket print ticket booking status of a performance
15 _exit exit
16 _reset reset database
"""


class DBWrapper(object):

    # class variable

    # command description = { command idx:command description}
    cmd_desc = {}

    # command functor = { command idx:command functor}
    cmd_mapper = {}



    # ABSTRACT FUNCTION #
    def _print_common(self,table):
        """
        - args : [table:str] = target table name
        - return = nothing

        - [role]
        - call table-dependent select query
        """

        try:
            with self.con.cursor() as cursor:
                sql = "SELECT * FROM "+ table
                cursor.execute(sql)
                result = cursor.fetchall()
                
                # precision exception about integer type
                # row_format = '{:^20.10}'*len(result)
                row_format = '{:^20}'*len(cursor.description)
                print('='*70)
                print( row_format.format( *[i[0] for i in cursor.description] ))
                print('='*70)
                for row in result:
                    print( row_format.format(*row.values()) )

        except Exception as e:
            print(e)

    def _insert_common(self,table,*args):
        try:
            proc='INSERT_'+table
            with self.con.cursor() as cursor:
                cursor.callproc(proc,args)
                rst = cursor.fetchone()
                if rst['valid']<0:
                    raise Exception('Insert valid error')
            print('success insert ')
            self.con.commit()

        except Exception as e:
            
            self.con.rollback()
            print(e,sys.exc_info()[-1].tb_lineno)

    def _insert_building(self):
        c1 = input("first filed: ")
        c2 = input("second filed: ")
        c3 = int(input("third field: "))
        self._insert_common('Building',c1,c2,c3)

    def _print_building(self):
        self._print_common('Building')

    def _print_audience(self):
        self._print_common('Audience')

    def _print_performance(self):
        self._print_common('Performance')


    def __init__(self,info):
        """
        - args [info:dict] = data base access info
        - return = nothing
        """
        self.info = info

    def _command_parse(self):
        """
        - args = nothing
        - return = nothing

        - [ role ]
        - read command from local file and parse
        """

        cmd_sep = re.compile(r'(?P<cmd>\d+)\s+(?P<func>[_a-z]+)\s+(?P<desc>.*)')
        with open('command.txt','r') as r_data:
            for row in r_data:
                print(row.strip())

                rst = re.match(cmd_sep,row)
                _td = rst.groupdict()
                self.cmd_desc[_td['cmd']]=_td['desc']
                self.cmd_mapper[_td['cmd']]= getattr(self, _td['func'])

    def connect(self):
        """
        - args = nothing
        - return = [connection status: True or False]

        - [role]
        - make connection about DB
        - call _command_parse function
        """
        try:
            self.con = pymysql.connect(**self.info)
            self._command_parse()
        except Exception as e:
            print('exception in connect',e)
            return False
        return True



    ## MAIN FUNCTION ##
    def main_loop(self):

        """
        main function - event loop from user
        """

        while True:
            cmd = input("Select your action: ")
            print(self.cmd_desc[cmd])
            self.cmd_mapper[cmd]()
            

    def __del__(self):

        # Must close connection
        if (self.con and self.con.open):
            self.con.close()
            print('connection is closed')
            



if __name__ == '__main__':
    db = DBWrapper(db_info)
    db.connect()
    db.main_loop()
