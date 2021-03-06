<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <style>
        body, pre, div, table, h1 {
            margin: 0;
            padding: 0;
            border: 0;
            vertical-align: baseline;
        }

        body {
            font-family: Arial, sans-serif;
        }

        .exception-page {
            padding: 30px;
        }

        .head {
            margin-bottom: 30px;
        }

        .head .exception-name {
            font-size: 14px;
            opacity: 0.5;
        }

        .head h1 {
            margin-bottom: 10px;
            color: #c50303;
        }

        a {
            color: #c50303;
        }

        .file {
            margin-bottom: 30px;
        }

        .info {
            margin-bottom: 10px;
            font-size: 14px;
        }

        table.lines {
            font-family: monospace;
            width: 100%;
            border: 1px solid #dadada;
            border-collapse:collapse;
        }

        table.lines .number {
            width: 40px;
            background-color: #f1f1f1;
            text-align: right;
        }

        table.lines td {
            border: none;
            padding: 2px 10px;
        }

        table.lines .highlight td {
            background-color: #fbdbd6;
            color: #a70202;
        }

        table.info .name {
            font-weight: bold;
        }

        table.args {
            margin-bottom: 20px;
        }

        table.args .name {
            font-weight: bold;
            padding-right: 10px;
        }

        table.args .arg {
            font-size: 80%;
            color: #999;
        }

        .pre {
            font-size: 10px;
            line-height: 1;
        }

        .pre-block .pre {
            display: none;
        }

        .pre-block.show .pre {
            display: block;
        }

        .pre-block.show .pre-link {
            display: none;
        }
    </style>
</head>
<body>
    <div class="exception-page">
        <div class="head">
            <h1 class="message">
                {$exception->getMessage()}
            </h1>
            <div class="exception-name">
                {$exception|class}
            </div>
        </div>


        {foreach $trace as $traceKey => $item}
            <div class="file">
                <table class="info">
                    {if isset($item.trace.class)}
                        <tr>
                            <td class="name">
                                Class:
                            </td>
                            <td class="value">
                                {$item.trace.class}
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td class="name">
                            File:
                        </td>
                        <td class="value">
                            {$item.fileName}
                        </td>
                    </tr>
                </table>
                {if isset($item.trace.args) && $item.trace.args}
                    <table class="args">
                        {foreach $item.trace.args as $argKey => $arg}
                            <tr class="arg">
                                <td class="name">
                                    Arg #{$argKey}:
                                </td>
                                <td class="value">
                                    {if $.php.is_array($arg) || $.php.is_object($arg)}
                                        <div class="pre-block" id="pre-{$traceKey}-{$argKey}">
                                            <a class="pre-link" href="javascript:void(0);" onclick="showPre('pre-{$traceKey}-{$argKey}')">
                                                {if $.php.is_array($arg)}
                                                    Array (show)
                                                {elseif $.php.is_object($arg)}
                                                    Object (show)
                                                {/if}
                                            </a>
                                            <pre class="pre">{$.php.print_r($arg)}</pre>
                                        </div>
                                    {else}
                                        {$arg}
                                    {/if}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                {/if}
                <table class="lines">
                    {foreach $item.itemLines as $number => $line}
                        <tr {if $item.trace.line - 1 == $number}class="highlight" {/if}>
                            <td class="number">
                                {$number}
                            </td>
                            <td class="code">
                                <pre>{$line}</pre>
                            </td>
                        </tr>
                    {/foreach}
                </table>
            </div>
        {/foreach}
    </div>
    <script type="text/javascript">
        function showPre(id) {
            var element = document.getElementById(id);
            element.classList.add("show");
        }
    </script>
</body>
</html>