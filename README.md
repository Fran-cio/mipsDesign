<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<p align="center">
    <a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&center=true&vCenter=true&width=560&height=27&lines=Hi+stranger;Supongo+que+viniste+en+busca+de+conocimiento;Usa+este+material+como+mera+inspiracion;Los+verdaderos+campeones+nunca+hacen+trampa;PLS" alt="Typing SVG" /></a>
</p>
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Fran-cio/mipsDesign">
    <img src=".images/logo.png" alt="Logo" width="300" height="300">
  </a>

<h3 align="center">mipsDesign</h3>

  <p align="center">
    Implementation of a MIPS Deluxe design processor using FPGA.
    <br />
    <a href="https://github.com/Fran-cio/mipsDesign"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Fran-cio/mipsDesign">View Demo</a>
    ·
    <a href="https://github.com/Fran-cio/mipsDesign/issues">Report Bug</a>
    ·
    <a href="https://github.com/Fran-cio/mipsDesign/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
The objective of this project was to put into practice the knowledge acquired during the "Computer Architecture" course regarding the internal design of processors, components, and how they interact with assembly code.

For a comprehensive analysis of the project, it is proposed to review [the academic report](INFORME.md), which contains all the theoretical concepts, design decisions and use of the project.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

![Verilog](https://img.shields.io/badge/Verilog-black?style=for-the-badge&logo=velog)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started
This project was developed using Xilinx Vivado Tool and the Nexys 4 DDR FPGA.
To send the binary file to the FPGA, the software Realterm was used.

1. Clone the repository using the command `git clone git@github.com:Fran-cio/mipsDesign.git --recursive`. This command not only clones the repository with the MIPS sources but also initializes the submodules used within the project.

    __Submodules__:
    * [FPGA-UART repository](https://github.com/Fran-cio/Modulo-UART)
    * [FPGA-ALU repository](https://github.com/Fran-cio/Modulo-ALU)
2. Create a new project in Vivado.

    __<font color='orange'>WARNING:</font>__ Do not add the sources yet!
3. Once the project is created, proceed to add the folder with the sources, as well as the simulation files if desired.
4. Add the constraints (located in the folder `FPGA-MIPS/Mips.srcs/constrs_1`) and the .xci file corresponding to the IP of the clock tree (located in the folder `FPGA-MIPS/Mips.srcs/ip/clk_wiz_0/clk_wiz_0.xci`).
5. Run "generate bitstream" in Vivado.
6. Connect the board.
7. Click on "AutoConnect".
8. Click on "Program device". Once programmed, you should see a __<font color='red'>red light</font>__ on the board.
9. At this point, we have the MIPS synthesis loaded on the board, so we proceed to download RealTerm. This app will allow us to send data via serial to the board.
10. In the "port" tab, set the baud rate to 9600 and choose the corresponding port.
11. __OPTIONAL:__ In the "send" tab, you can send a "P" to see if it returns 0 and thus check that the serial connection has been established correctly.
12. Now we need to generate the binary. To do this, go to `FPGA-MIPS/python_src`. There you will find a .asm file called *src_code.asm*. Place the desired assembly code there. In the same folder, you will also find test files with their respective analyses.
13. In this step, we generate the binary. Run `python3 -W ignore assembler.py`. This will generate a .hex file named *output_code.hex*.

    __<font color='orange'>DISCLAIMER:</font>__ You may need to install some Python modules if you don't have them. Follow the terminal logs in such case.

14. Now we proceed to load the binary. In the "send" tab of RealTerm, send a letter *'B'*.
15. Now copy and paste the binary, or import it into the corresponding section in RealTerm.
16. When the binary is successfully loaded, you should see a __<font color='green'>green light</font>__ on the board.
17. Now you can follow the commands and state machine presented in the report to perform the desired execution. For example, you could send a *'G'* to run the entire program. In that case, you would see a __<font color='blue'>blue light</font>__ when the execution finishes.

__<font color='orange'>DISCLAIMER:</font>__ LED colors may vary depending on the board used or if constraints are modified.<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage
## Operation Modes

There are three additional requirements related to the interaction between the processor and the user. For this purpose, the Super Unit of Operation and Debug (SUOD) was designed. It serves as a large state machine that generates actions based on user input.
### Actions of the SUOD

The SUOD (System User Operation Device) is a unit that provides a main menu type interface for project execution. It has a set of commands received via UART (Universal Asynchronous Receiver-Transmitter) and performs a set of actions.

Commands:

| Command | Description |
| ------- | ----------- |
| "G"     | Run mode, executes the loaded program. |
| "B"     | Enters "BootLoader" mode to receive binary until a halt instruction is received. |
| "S"     | Advances one clock cycle. |
| "P"     | Returns the value of the Program Counter (PC). |
| "C"     | Resets the program. |
| "T"     | Increments the register pointer. |
| "R"     | Returns the value of the pointed register space. |
| "E"     | Decrements the register pointer. |
| ","     | Increments the memory pointer. |
| "M"     | Returns the value of the pointed memory space. |
| "N"     | Decrements the memory pointer. |
| "F"     | Clears the loaded program. |


### Implemented Instructions

| Category | Instruction | Type | Example | Comment |
| --- | --- | --- | --- | --- |
| Arithmetic | ADDU | R | addu $s1,$s2,$s3 | Unsigned addition between registers |
|  | SUBU | R | sub $s1,$s2,$s3 | Unsigned subtraction between registers |
|  | ADDI | I | addi $s1,$s2,20 | Immediate addition |
| Information Transfer | LB | I | lb $s1,20($s2) | Load Byte |
|  | LH | I | lh $s1,20($s2) | Load Half |
|  | LW | I | lw $s1,20($s2) | Load Word |
|  | LWU | I | lwu $s1,20($s2) | Load Word Unsigned |
|  | LBU | I | lbu $s1,20($s2) | Load Byte Unsigned |
|  | LHU | I | lhu $s1,20($s2) | Load Half Unsigned |
|  | SB | I | sb $s1,20($s2) | Store Byte |
|  | SH | I | sh $s1,20($s2) | Store Half |
|  | SW | I | sw $s1,20($s2) | Store Word |
|  | LUI | I | lui $s1,20 | Load Upper Immediate |
| Logic | SLL | R | sll $s1,$s2,10 | Shift Left Logical |
|  | SRL | R | srl $s1,$s2,10 | Shift Right Logical |
|  | SRA | R | sra $s1,$s2,10 | Shift Right Arithmetic |
|  | SLLV | R | sllv $s1,$s2,10 | Shift Left Logical Immediate |
|  | SRLV | R | srlv $s1,$s2,10 | Shift Right Logical Immediate |
|  | SRAV | R | srav $s1,$s2,10 | Shift Right Arithmetic Immediate |
|  | AND | R | and $s1,$s2,$s3 | AND operation |
|  | OR | R | or $s1,$s2,$s3 | OR operation |
|  | XOR | R | xor $s1,$s2,$s3 | XOR operation |
|  | NOR | R | nor $s1,$s2,$s3 | NOR operation |
|  | SLT | R | slt $s1,$s2,$s3 | Set Less Than |
|  | ANDI | I | andi $s1,$s2,20 | Immediate AND operation |
|  | ORI | I | ori $s1,$s2,20 | Immediate OR operation |
|  | XORI | I | xori $s1,$s2,20 | Immediate XOR operation |
|  | SLTI | I | slti $s1,$s2,20 | Set Less Than Immediate |
| Conditional Jump | BEQ | I | beq $s1,$s2,25 | Branch if Equal |
|  | BNE | I | bne $s1,$s2,25 | Branch if Not Equal |
| Unconditional Jump | JR | I | jr $ra | Jump to Register Address |
|  | JALR | I | jalr $s1,s10 | Jump to Register Address and Link |
|  | J | J | j 2500 | Jump to Immediate Address |
|  | JAL | J | jal 2500 | Jump to Immediate Address and Link |
|  | HALT | H | halt | Halt Instruction |


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the Beerware License🍻. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Francisco Ciordia Cantarella - francisco.ciordia.cantarella@gmail.com

Project Link: [https://github.com/Fran-Cio/mipsDesign](https://github.com/Fran-Cio/mipsDesign)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [MIPS Instruction Set](https://www.cs.cmu.edu/afs/cs/academic/class/15740-f97/public/doc/mips-isa.pdf)
* [Nexys 4 DDR constraints](https://github.com/Digilent/digilent-xdc/blob/master/Nexys-4-DDR-Master.xdc)
* [Pretty Badges](https://github.com/Ileriayo/markdown-badges)
* [Logo Generator](https://www.bing.com/.images/create?FORM=BICMB1&ssp=1&darkschemeovr=0&setlang=es-CL&safesearch=moderate&toWww=1&redig=8195C3604CE2443CAD2B9B2FB3512087)
* [Template of this readme](https://github.com/othneildrew/Best-README-Template?tab=readme-ov-file)

> Patterson, David A., and John L. Hennessy. *Computer Organization and Design MIPS Edition: The Hardware/Software Interface*. Edited by David A. Patterson and John L. Hennessy, Elsevier Science, 2014. Accessed 27 January 2023.
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & .images -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Fran-Cio/mipsDesign.svg?style=for-the-badge
[contributors-url]: https://github.com/Fran-cio/mipsDesign/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Fran-cio/mipsDesign.svg?style=for-the-badge
[forks-url]: https://github.com/Fran-Cio/mipsDesign/network/members
[stars-shield]: https://img.shields.io/github/stars/Fran-Cio/mipsDesign.svg?style=for-the-badge
[stars-url]: https://github.com/Fran-Cio/mipsDesign/stargazers
[issues-shield]: https://img.shields.io/github/issues/Fran-Cio/mipsDesign.svg?style=for-the-badge
[issues-url]: https://github.com/Fran-Cio/mipsDesign/issues
[license-shield]: https://img.shields.io/badge/license-Beerware%F0%9F%8D%BB-green?style=for-the-badge
[license-url]: https://github.com/Fran-Cio/mipsDesign/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/francisco-ciordia-cantarella-5323461b8/
[product-screenshot]: .images/vista_fisica.jpeg
[usage-example]: .images/example.png


