#import sys
#import os
import json
import testLib
import testSimple
#import testAdditional
import unittest.loader

class MyTests(testLib.RestTestCase):

        def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
                expected = { 'errCode' : errCode }
                if count is not None:expected['count']  = count
                self.assertDictEqual(expected, respData)


        # Making sure that no equal usernames are saved into the data base.
        def testAddSame(self):

                respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user2','password' : 'password'} )
                self.assertResponse(respData, count = 1)
                
                respData = self.makeRequest("/users/add", method = "POST", data = { 'user' : 'user2', 'password' : 'password'})
		self.assertResponse(respData, count = None, errCode = -2)

		
	# Making sure that password is longer than 128.
        def testAddLongPassword(self):
                respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user2',
                                                                                  'password' : 'passwordpassword0password1password2password3password4password5password6password7password8ppassword0password1password2password3password'} )
                self.assertResponse(respData, count = None, errCode = -4)

        # Making sure that username is longer than 128.
        def testAddLongUserName(self):
                respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890us',
                                                                                  'password' : 'password'} )
                self.assertResponse(respData, count= None, errCode = -3)

        # Making sure that password is longer than 128.
        def testLogInLongPassword(self):
                respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user2',
                                                                                  'password' : 'passwordpassword0password1password2password3password4password5password6password7password8ppassword0password1password2password3password'} )
                self.assertResponse(respData, count = None, errCode = -4)

        # Making sure that username is longer than 128.
        def testLogInLongUserName(self):
                respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890user01234567890us',
                                                                                  'password' : 'password'} )
                self.assertResponse(respData, count= None, errCode = -3)

        #Making sure the counter is working correctly
        def testTheCounter(self):
                respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'NewUser','password' : 'password'} )
                self.assertResponse(respData, count = 1)
                respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'NewUser','password' : 'password'} )
                self.assertResponse(respData, count = 2)
                respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'NewUser','password' : 'password'} )
                self.assertResponse(respData, count = 3)

        #Validating user
        def testExistingUser(self):
                respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'NewUser','password' : 'password'} )
                self.assertResponse(respData, count = 1)
                respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'NewUser','password' : 'passwor'} )
                self.assertResponse(respData, count = None, errCode = -1)
                

        

