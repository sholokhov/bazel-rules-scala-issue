# Do not edit. bazel-deps autogenerates this file from jvm-dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.google.protobuf:protobuf-java:3.6.1", "lang": "java", "sha1": "0d06d46ecfd92ec6d0f3b423b4cd81cb38d8b924", "sha256": "fb66d913ff0578553b2e28a3338cbbbe2657e6cfe0e98d939f23aea219daf508", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.6.1/protobuf-java-3.6.1.jar", "source": {"sha1": "b0782bcd21ad5c52031e74efbc4c3d6a6df96130", "sha256": "9e8996b159b1b676adfe58bce785a73ded6e4a21c25a69251ef25e585ebfaeee", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.6.1/protobuf-java-3.6.1-sources.jar"} , "name": "com_google_protobuf_protobuf_java", "actual": "@com_google_protobuf_protobuf_java//jar", "bind": "jar/com/google/protobuf/protobuf_java"},
    {"artifact": "com.lihaoyi:fastparse-utils_2.12:1.0.0", "lang": "scala", "sha1": "02900ec8460abec27913f4154b338e61fd482607", "sha256": "fb6cd6484e21459e11fcd45f22f07ad75e3cb29eca0650b39aa388d13c8e7d0a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/lihaoyi/fastparse-utils_2.12/1.0.0/fastparse-utils_2.12-1.0.0.jar", "source": {"sha1": "891f76cff455350adc2f122421b67855f93c8dc3", "sha256": "19e055e9d870f2a2cec5a8e0b892f9afb6e4350ecce315ca519458c4f52f9253", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/lihaoyi/fastparse-utils_2.12/1.0.0/fastparse-utils_2.12-1.0.0-sources.jar"} , "name": "com_lihaoyi_fastparse_utils_2_12", "actual": "@com_lihaoyi_fastparse_utils_2_12//jar:file", "bind": "jar/com/lihaoyi/fastparse_utils_2_12"},
    {"artifact": "com.lihaoyi:fastparse_2.12:1.0.0", "lang": "scala", "sha1": "2473a344aa1200fd50b7ff78281188c172f9cfcb", "sha256": "1227a00a26a4ad76ddcfa6eae2416687df7f3c039553d586324b32ba0a528fcc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/lihaoyi/fastparse_2.12/1.0.0/fastparse_2.12-1.0.0.jar", "source": {"sha1": "b1fdfd4c95bdb3f49ec78837be78d657a5ac86c0", "sha256": "290c1e9a4bad4d3724daec48324083fd0d97f51981a3fabbf75e2de1303da5ca", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/lihaoyi/fastparse_2.12/1.0.0/fastparse_2.12-1.0.0-sources.jar"} , "name": "com_lihaoyi_fastparse_2_12", "actual": "@com_lihaoyi_fastparse_2_12//jar:file", "bind": "jar/com/lihaoyi/fastparse_2_12"},
    {"artifact": "com.lihaoyi:sourcecode_2.12:0.1.4", "lang": "scala", "sha1": "ef9a771975cb0860f2b42778c5cf1f5d76818979", "sha256": "9a3134484e596205d0acdcccd260e0854346f266cb4d24e1b8a31be54fbaf6d9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.4/sourcecode_2.12-0.1.4.jar", "source": {"sha1": "ffb135dacaf0d989c260a486c8b86867bcab2e22", "sha256": "c5c53ba31a9f891988f9e21595e8728956be22d9ab9442e140840d0a73be8261", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/lihaoyi/sourcecode_2.12/0.1.4/sourcecode_2.12-0.1.4-sources.jar"} , "name": "com_lihaoyi_sourcecode_2_12", "actual": "@com_lihaoyi_sourcecode_2_12//jar:file", "bind": "jar/com/lihaoyi/sourcecode_2_12"},
    {"artifact": "com.thesamet.scalapb:lenses_2.12:0.8.4", "lang": "scala", "sha1": "f4065b07cc592ca5db692f711cac9bd2b0182307", "sha256": "79100162924477084ac2ab35b02067ee875e5dade58a33e882ec9f2900418de3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/thesamet/scalapb/lenses_2.12/0.8.4/lenses_2.12-0.8.4.jar", "source": {"sha1": "2774c15fc044a07c2464eeddf608c7a017f92dc3", "sha256": "3b3b03665cdab70d3511c60423b0674e44f5ded1447db209e230800b81f20101", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/thesamet/scalapb/lenses_2.12/0.8.4/lenses_2.12-0.8.4-sources.jar"} , "name": "com_thesamet_scalapb_lenses_2_12", "actual": "@com_thesamet_scalapb_lenses_2_12//jar:file", "bind": "jar/com/thesamet/scalapb/lenses_2_12"},
    {"artifact": "com.thesamet.scalapb:scalapb-runtime_2.12:0.8.4", "lang": "scala", "sha1": "42265bf38f55eaed5aa24e026300a3d73c280e49", "sha256": "82596e3235f8ccda30fbd6290e0ba314ba880283874658fc876217701d3ef5e4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/thesamet/scalapb/scalapb-runtime_2.12/0.8.4/scalapb-runtime_2.12-0.8.4.jar", "source": {"sha1": "a6c4f399a7f02e161aa4ac9ca29cb0a6b873f37f", "sha256": "3d6e6010d44f73206d8f11da4df4132d0f87605210e464120b1f6ff639f4eb4a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/thesamet/scalapb/scalapb-runtime_2.12/0.8.4/scalapb-runtime_2.12-0.8.4-sources.jar"} , "name": "com_thesamet_scalapb_scalapb_runtime_2_12", "actual": "@com_thesamet_scalapb_scalapb_runtime_2_12//jar:file", "bind": "jar/com/thesamet/scalapb/scalapb_runtime_2_12"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
