<a id="readme-top"></a>

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



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Lutum-IFSP/TicketFlow">
    <img src="https://i.imgur.com/vnhd6qU.png" alt="Logo" width="100" height="100">
  </a>

  <h3 align="center">TicketFlow</h3>

  <p align="center">
    An opensource streamlined helpdesk solution that simplifies ticket management and support workflows
    <br />
    <br />
    <br />
    <a href="https://github.com/Lutum-IFSP/TicketFlow">View Repository</a>
    ·
    <a href="https://github.com/Lutum-IFSP/TicketFlow/issues">Report Bug</a>
    ·
    <a href="https://github.com/Lutum-IFSP/TicketFlow/issues">Request Feature</a>
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
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contributors">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://github.com/Lutum-IFSP/TicketFlow)

TicketFlow is a streamlined helpdesk solution that simplifies ticket management and support workflows. With intuitive dashboards, automated ticket assignment, and real-time status updates, TicketFlow helps teams resolve issues faster and enhance customer satisfaction. Ideal for businesses of all sizes looking to improve support efficiency and communication.
Some features of TicketFlow includes:
* Robust security protocols, including strict access controls, safeguard sensitive information.
* End-to-end encryption for data at rest and in transit ensures that all information is securely stored and shared.
* A streamlined interface makes ticket management intuitive, reducing training time and allowing teams to focus on solutions.
* Dashboard views and customizable reports provide real-time visibility into support metrics and performance trends.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

TicketFlow is powered mainly by:

* ![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)

* ![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)

* ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

* ![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)

* ![MySQL](https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white)

* ![Apache Maven](https://img.shields.io/badge/Apache%20Maven-C71A36?style=for-the-badge&logo=Apache%20Maven&logoColor=white)
* ![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This project works by JSP, Maven, MySQL and Cloudinary, so you need to have a basic knowledge of those tools

### Installation

_Below is how to install and test TicketFlow_

1. Get a free API Key at [https://cloudinary.com](https://cloudinary.com)
2. Clone the repo
   ```sh
   git clone https://github.com/Lutum-IFSP/TicketFlow.git
   ```
3. Create a `.env` at src/main/java
4. Enter your API in `.env`, like this template
   ```ini
   CLOUDINARY_URL=cloudinary://<API_KEY>:<API_SECRET>@<CLOUD_NAME>
   ```
5. Package the project as a `*.war` with maven
   ```sh
   mvn package -f ".\pom.xml"
   ```
6. Install a Tomcat server and add the `*.war` as a deployment

## Contributors

![https://github.com/Lutum-IFSP/TicketFlow/graphs/contributors](https://contrib.rocks/image?repo=Lutum-IFSP/TicketFlow)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Lutum - equipelutum@gmail.com

Project Link: [https://github.com/Lutum-IFSP/TicketFlow](https://github.com/Lutum-IFSP/TicketFlow)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Lutum-IFSP/TicketFlow.svg?style=for-the-badge
[contributors-url]: https://github.com/Lutum-IFSP/TicketFlow/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Lutum-IFSP/TicketFlow.svg?style=for-the-badge
[forks-url]: https://github.com/Lutum-IFSP/TicketFlow/network/members
[stars-shield]: https://img.shields.io/github/stars/Lutum-IFSP/TicketFlow.svg?style=for-the-badge
[stars-url]: https://github.com/Lutum-IFSP/TicketFlow/stargazers
[issues-shield]: https://img.shields.io/github/issues/Lutum-IFSP/TicketFlow.svg?style=for-the-badge
[issues-url]: https://github.com/Lutum-IFSP/TicketFlow/issues
[license-shield]: https://img.shields.io/github/license/Lutum-IFSP/TicketFlow.svg?style=for-the-badge
[license-url]: https://github.com/Lutum-IFSP/TicketFlow/blob/master/LICENSE
[product-screenshot]: https://i.imgur.com/jSepbqy.png
