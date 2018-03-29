<%--
  Created by IntelliJ IDEA.
  User: Dove
  Date: 2018/3/6
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/common/taglib.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/common/head.jsp"%>
    <style>
        .row{
            margin-bottom: 5px;
        }
        #photo {
            max-width: 100%;
        }
        .img-preview {
            width: 100px;
            height: 100px;
            overflow: hidden;
        }
        button {
            margin-top:10px;
        }
        #result {
            width: 150px;
            height: 150px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm-12 text-center">
            <label for="input" class="btn btn-danger" id="">
                <span>选择图片</span>
                <input type="file" id="input" class="sr-only">
            </label>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6 col-sm-offset-2">
            <img src="" id="photo">
        </div>
        <div class="col-sm-2">
            <div>
                <p>
                    预览(100*100)：
                </p>
                <div class="img-preview">
                </div>
            </div>
            <button class="btn btn-primary" onclick="crop()">裁剪图片</button>
            <div>
                <br/>
                <p>
                    结果：
                </p>
                <img src="" alt="裁剪结果" id="result">
            </div>
        </div>
    </div>
</div>


<%@ include file="/WEB-INF/common/script.jsp"%>
<script>
    // 修改自官方demo的js
    var initCropper = function (img, input){
        var $image = img;
        var options = {
            aspectRatio: 1, // 纵横比
            viewMode: 2,
            preview: '.img-preview' // 预览图的class名
        };
        $image.cropper(options);
        var $inputImage = input;
        var uploadedImageURL;
        if (URL) {
            // 给input添加监听
            $inputImage.change(function () {
                var files = this.files;
                var file;
                if (!$image.data('cropper')) {
                    return;
                }
                if (files && files.length) {
                    file = files[0];
                    // 判断是否是图像文件
                    if (/^image\/\w+$/.test(file.type)) {
                        // 如果URL已存在就先释放
                        if (uploadedImageURL) {
                            URL.revokeObjectURL(uploadedImageURL);
                        }
                        uploadedImageURL = URL.createObjectURL(file);
                        // 销毁cropper后更改src属性再重新创建cropper
                        $image.cropper('destroy').attr('src', uploadedImageURL).cropper(options);
                        $inputImage.val('');
                    } else {
                        window.alert('请选择一个图像文件！');
                    }
                }
            });
        } else {
            $inputImage.prop('disabled', true).addClass('disabled');
        }
    }
    var crop = function(){
        var $image = $('#photo');
        var $target = $('#result');
        $image.cropper('getCroppedCanvas',{
            width:300, // 裁剪后的长宽
            height:300
        }).toBlob(function(blob){
            // 裁剪后将图片放到指定标签
            $target.attr('src', URL.createObjectURL(blob));
        });
    }
    $(function(){
        initCropper($('#photo'),$('#input'));
    });
</script>
</body>
</html>
