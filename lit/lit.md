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
