<h1 align="center"> AES with SPI </h1>

<div align="center"><img src="https://media.geeksforgeeks.org/wp-content/uploads/20200427214520/AES1.png" alt="AES logo" width="1000px"></div>

## Table of Contents

* [Project Description](#Project-Description)
* [Project Document and References](#Project-Document-and-References)

# Project Description

The common encryption technique AES utilizes key sizes of 128, 192, and 256 bits and operates on 128-bit blocks. In this project, we were required to implement encryption and decryption modules for all three key sizes.

The encryption and decryption modules are built with a serial interface that complies with the SPI specification to simplify data transfer and system integration. The modules can send encrypted or decrypted data or receive input data and keys bit-by-bit over a number of clock cycles using the SPI interface. In this project, the widely used SPI mode 0 is utilized.

Furthermore, we needed to implement a thorough testbench that validates the operation of the encryption and decryption modules. To guarantee that the modules operate correctly in a variety of contexts, the testbench employs numerous test cases with varying messages and keys. It has self-checking features and reports how many test cases passed and failed.

A test wrapper is also used to make testing on the DE1-SoC board easier. The encryption and decryption modules' inputs are driven by the test wrapper, which also uses an LED to display the test results. This makes it simple to check the modules' functionality in a hardware setting.

# Project Document and References
* [CMPN111 Spring 2023 - Project Description.pdf](https://github.com/AbdullahAyman02/AES-using-Verilog-HDL/files/12693709/CMPN111.Spring.2023.-.Project.Description.pdf)
* [NIST.FIPS.197.pdf](https://github.com/AbdullahAyman02/AES-using-Verilog-HDL/files/12693715/NIST.FIPS.197.pdf)
* [Introduction to SPI Interface.pdf](https://github.com/AbdullahAyman02/AES-using-Verilog-HDL/files/12693716/Introduction.to.SPI.Interface.pdf)
