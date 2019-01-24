<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>测评分析</title>
    <link rel="stylesheet" href="/layui/css/layui.css" media="all">
</head>
<body>
<div class="demoTable">
    <div class="layui-inline">
        <label class="layui-label">&nbsp;&nbsp;选择申请时间：</label>
        <div class="layui-inline">
            <input type="text" class="layui-input" id="start" readonly="readonly" placeholder="请选择开始时间">
        </div>
        <div class="layui-inline" style="margin-right: 2px; margin-top: 2px">
            <input type="text" class="layui-input" id="end" readonly="readonly" placeholder="请选择结束时间">
        </div>
    </div>
    <div class="layui-inline" style="margin-right: 1px; margin-top: 2px">
        <button class="layui-btn layui-btn-radius layui-btn-normal" onclick="shuaxin()">
            <i class="layui-icon layui-icon-search"></i>
            搜索
        </button>
    </div>
</div>
<!--设置展示ECharts图表的区域 -->
<div id="myDiv1" style="height: 75%; width: 100%;right: 6%"></div>
</body>
<script src="/layui/jquery-3.3.1.min.js"></script>
<script src="/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="/jsp/comprehensive/echarts.common.min.js"></script>
<script type="text/javascript" src="/jsp/comprehensive/vintage.js"></script>
<script type="text/javascript">
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //日期选择
        laydate.render({
            elem: '#start', trigger: 'click', showBottom: false
        });
        laydate.render({
            elem: '#end', trigger: 'click', showBottom: false
        });
    });
    var myChart = echarts.init(document.getElementById('myDiv1'), 'vintage');
    myChart.setOption({
        tooltip: {
            trigger: 'axis',
        }, toolbox: {
            feature: {
                dataView: {
                    show: true, readOnly: false
                }, restore: {
                    show: true
                }, saveAsImage: {
                    show: true
                }, magicType: {
                    type: ['line', 'bar']
                },
            }
        }, dataZoom: [{}, {
            type: 'inside'
        }], legend: {
            data: [],
            type: 'scroll',
            orient: 'horizontal',
            top: '2%',
            bottom: '250%',
        }, xAxis: {
            data: []
        }, yAxis: {
            type: 'value', min: 0, max: 'dataMax'
        }, series: []
    });

    //搜索按钮
    function shuaxin() {
        var start = $('#start').val(), end = $('#end').val();
        reload(start, end);
        $('#start').val('');
        end = $('#end').val('');
    }

    //加载部分
    function reload(start, end) {
        myChart.showLoading();
        var selected = {};
        //异步加载数据
        $.ajax({
            type: "POST", url: "/statistics/gettt.do", dataType: 'json', //會把回傳的字符串自動轉換為json對象！
            data: {start: start, end: end},
            success: function (data) {
                myChart.hideLoading();
                for (var i = 0; i < data.data.length; i++) {
                    var name = data.legend[i];
                    selected[name] = i < 1;
                }
                myChart.setOption({
                    legend: {
                        data: data.legend,
                        selected:selected,
                    }, xAxis: {
                        data: data.xA
                    }, series: data.data
                });
            }
        });
    }

    $(function () {
        reload();
    })
</script>
</html>