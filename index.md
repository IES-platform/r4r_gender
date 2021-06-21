**Resources for Researchers (R4R) on ...**
## Innovation, IP and Gender  (R4R Gender)

Welcome to the IES Gender open source project.

The repository intends to hold assets that contribute towards scientific advancements on the subjects of IP, Gender and Innovation.

We invite you to contribute by proposing, correcting and improving any of the following:

- Research questions.
- Data.
- Tools.
- Methodologies.
- Documentation.

# Contributing

We kindly ask that contributors follow our [Contribution Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md).

# Contents

## 1. [World Gender-Name Dictionary (WGND)](wgnd/README.md)

We compiled a worldwide gender-name dictionary which identifies gender for **25+ million names in 195 countries or territories**.  

# [Change Log](CHANGELOG.md)

# [License](LICENSE.md)

<div id="zoterotable"></div>
<script>
                fetch('https://api.zotero.org/groups/2551265/collections/6HBJVXIA/items?v=3&key=z8bcfbp0CfSjzBrnafyQjv3R&tag=Theme%3A+Gender&format=json')
                    .then(function (response) {
                        return response.json();
                    })
                    .then(function (data) {
                        appendData(data);
                    })
                    .catch(function (err) {
                        console.log('error: ' + err);
                    });

                function appendData(data) {

                    var mainContainer = document.getElementById("zoterotable");

                    var table = document.createElement("table");
                    table.setAttribute('class','table table-bordered table-striped');

                    var tablehead = document.createElement('thead');

                    tablehead.innerHTML = '<tr><th>Title</th><th>Author</th><th>Year</th></tr>';

                    table.appendChild(tablehead);

                    var tablebody = document.createElement("tbody");


                    for (var i = 0; i < data.length; i++) {
                        var row = document.createElement("tr");
                        row.innerHTML = '<td><a href="' + data[i].data.url + '" target="_blank">' + data[i].data.title + '</a></td><td>' + data[i].meta.creatorSummary + '</td><td>' + data[i].meta.parsedDate.substring(0, 4) + '</td>';
                        tablebody.appendChild(row);
                    }
                    table.appendChild(tablebody);

                    zoterotable.appendChild(table);

                }
            </script>
