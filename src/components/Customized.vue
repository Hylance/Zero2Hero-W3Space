<template>
  <div class="main">
    <div class="customized">
      <p class="close" @click="closeCustomized">X</p>
      <div class="build">
        <span>Build</span
        ><img
          :class="{ clearImg: true, active: clearImg == true }"
          src="../assets/clear.svg"
          @click="clearBuild('clear')"
        />
        <img
          :class="{ moveImg: true, active: moveImg == true }"
          src="../assets/move.svg"
          @click="clearBuild('move')"
        />
        <img
          :class="{ clearUploadImg: true, active: clearUploadImg == true }"
          src="../assets/clearUpload.svg"
          @click="clearUpload()"
        />
      </div>
      <div class="list">
        <p class="objects">Decoration</p>
        <div
          class="item"
          v-for="i in 19"
          :key="'Decoration' + i"
          :id="'Decoration' + i"
          @click="build(1, 'Decoration', i)"
        >
          <img :src="require('../assets/build/Decoration' + i + '.png')" />
        </div>
        <div
          v-for="item in uploadList.Decoration"
          :key="'Decoration' + item"
          class="uploadItem"
        >
          <div
            v-show="clearUploadImg == true"
            class="uploadClear"
            @click="removeUpload(item, 'Decoration')"
          >
            <img src="../assets/clearUpload2.svg" />
          </div>
          <div
            class="item"
            :id="'Decoration' + item"
            @click="build(2, 'Decoration', item)"
          >
            <img
              :src="
                locationUrl + '/thingroomicon/userroom/' + roomid + '/' + item
              "
            />
          </div>
        </div>
        <p class="objects">Floor</p>
        <div
          class="item"
          v-for="i in 8"
          :key="'Floor' + i"
          :id="'Floor' + i"
          @click="build(1, 'Floor', i)"
        >
          <img :src="require('../assets/build/Floor' + i + '.png')" />
        </div>
        <div
          v-for="item in uploadList.Floor"
          :key="'Floor' + item"
          class="uploadItem"
        >
          <div
            v-show="clearUploadImg == true"
            class="uploadClear"
            @click="removeUpload(item, 'Floor')"
          >
            <img src="../assets/clearUpload2.svg" />
          </div>
          <div
            class="item"
            :id="'Floor' + item"
            @click="build(2, 'Floor', item)"
          >
            <img
              :src="
                locationUrl + '/thingroomicon/userroom/' + roomid + '/' + item
              "
            />
          </div>
        </div>

        <p class="objects">Furniture</p>
        <div
          class="item"
          v-for="i in 23"
          :key="'Furniture' + i"
          :id="'Furniture' + i"
          @click="build(1, 'Furniture', i)"
        >
          <img :src="require('../assets/build/Furniture' + i + '.png')" />
        </div>
        <div
          v-for="item in uploadList.Furniture"
          :key="'Furniture' + item"
          class="uploadItem"
        >
          <div
            v-show="clearUploadImg == true"
            class="uploadClear"
            @click="removeUpload(item, 'Furniture')"
          >
            <img src="../assets/clearUpload2.svg" />
          </div>
          <div
            class="item"
            :id="'Furniture' + item"
            @click="build(2, 'Furniture', item)"
          >
            <img
              :src="
                locationUrl + '/thingroomicon/userroom/' + roomid + '/' + item
              "
            />
          </div>
        </div>
        <p class="objects">Tile</p>
        <div
          class="item"
          v-for="i in 12"
          :key="'Tile' + i"
          :id="'Tile' + i"
          @click="build(1, 'Tile', i)"
        >
          <img :src="require('../assets/build/Tile' + i + '.png')" />
        </div>
        <div
          v-for="item in uploadList.Tile"
          :key="'Tile' + item"
          class="uploadItem"
        >
          <div
            v-show="clearUploadImg == true"
            class="uploadClear"
            @click="removeUpload(item, 'Tile')"
          >
            <img src="../assets/clearUpload2.svg" />
          </div>
          <div class="item" :id="'Tile' + item" @click="build(2, 'Tile', item)">
            <img
              :src="
                locationUrl + '/thingroomicon/userroom/' + roomid + '/' + item
              "
            />
          </div>
        </div>
        <p class="objects">Wall</p>
        <div
          class="item"
          v-for="i in 2"
          :key="'Wall' + i"
          :id="'Wall' + i"
          @click="build(1, 'Wall', i)"
        >
          <img :src="require('../assets/build/Wall' + i + '.png')" />
        </div>
        <div
          v-for="item in uploadList.Wall"
          :key="'Wall' + item"
          class="uploadItem"
        >
          <div
            v-show="clearUploadImg == true"
            class="uploadClear"
            @click="removeUpload(item, 'Wall')"
          >
            <img src="../assets/clearUpload2.svg" />
          </div>
          <div class="item" :id="'Wall' + item" @click="build(2, 'Wall', item)">
            <img
              :src="
                locationUrl + '/thingroomicon/userroom/' + roomid + '/' + item
              "
            />
          </div>
        </div>
      </div>
      <div class="button">
        <div @click="uploadLogo">Upload Logo</div>
        <div @click="showUploadImage = true">Upload Image</div>
      </div>
    </div>
    <div
      class="configureRegion"
      @click="getMouseXY($event)"
      @mousemove="mousemove($event)"
    >
      <img src="" id="mouseImg" style="position: absolute" />
    </div>

    <div v-show="showUploadImage" class="uploadImage">
      <div class="uploadInfo">
        <div class="close" @click="showUploadImage = false">X</div>
        <p>Upload image</p>
        <div class="uploadContent">
          <div class="image">
            <div class="upImgSrc">
              <img :src="upImgSrc" />
            </div>
            <div class="selectUpImg" v-if="!upImgSrc || upImgSrc === ''">
              <img src="../assets/upload.svg" />
              <p>Drag image or click to upload</p>
            </div>
            <input
              class="filePrew"
              type="file"
              accept=".jpg,.jpeg,.png"
              @change="addImage($event)"
              ref="logoImg"
            />
            <input
              id="oldimg"
              name="oldimg"
              v-model="upOldimg"
              value=""
              type="hidden"
            />
          </div>
          <div class="info">
            <select v-model="typeName">
              <option
                v-for="item in typeList"
                v-bind:value="item"
                v-text="item"
                :key="item"
              ></option>
            </select>
            <div class="button">
              <div @click="uploadImage">Create</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import $ from "jquery";
import axios from "axios";
export default {
  name: "Customized",
  data() {
    return {
      oldImg: null,
      img: null,
      imgX: 0,
      imgY: 0,
      projectAddress1: "0x66c37c9e4418d8Db8dAB9381B352FE6c6b2F166a", //0x66c37c9e4418d8db8dab9381b352fe6c6b2f166a //0x8e0ed8482d7374380cf548317a9d78288651c456
      projectAddress2: "0xcd4b068ac9c9deb53f01e6691b3fdd124760eab0",
      bulidType: null,
      clearImg: false,
      moveImg: false,
      showUploadImage: false,
      logoImg: "",
      upImgSrc: "",
      imageName: "",
      logoFile: "",
      upOldimg: null,
      typeName: "Decoration",
      typeList: ["Decoration", "Floor", "Furniture", "Tile", "Wall"],
      uploadList: {
        Decoration: [],
        Floor: [],
        Furniture: [],
        Tile: [],
        Wall: [],
      },
      clearUploadImg: false,
    };
  },
  props: ["isAdmin", "account", "webRtc", "roomid", "locationUrl"],
  computed: {},
  created() {
    window["delThing"] = async (name) => {
      if (this.bulidType === "move") {
        if (name.split(".").length > 1) {
          this.build(2, "", "", name);
        } else {
          this.build(1, "", "", name);
        }
      }
    };
    window["userthingOK"] = async (list) => {
      let userList = JSON.parse(list);
      // console.log(userList);
      this.uploadList.Decoration = userList.Decoration.split("-").filter(
        function (s) {
          return s && s.trim();
        }
      );
      this.uploadList.Floor = userList.Floor.split("-").filter(function (s) {
        return s && s.trim();
      });
      this.uploadList.Furniture = userList.Furniture.split("-").filter(
        function (s) {
          return s && s.trim();
        }
      );
      this.uploadList.Tile = userList.Tile.split("-").filter(function (s) {
        return s && s.trim();
      });
      this.uploadList.Wall = userList.Wall.split("-").filter(function (s) {
        return s && s.trim();
      });
    };
    window["upthingRoomOK"] = async () => {
      console.log("upthingRoomOK");
      Object.keys(this.uploadList).forEach((key) => {
        if (key === this.typeName) {
          this.uploadList[key].push(this.imageName);
          this.upImgSrc = "";
          this.logoFile = "";
        }
      });
    };
    
  },
  methods: {
    removeUpload(name, type) {
      this.webRtc.sendToGdevelop("delthingroom", {
        name: name,
        floor: type,
      });
      this.uploadList[type].forEach((e, index) => {
        if (e === name) {
          this.uploadList[type].splice(index, 1);
        }
      });
      // console.log(this.uploadList[type]);
    },
    uploadImage() {
      // console.log(this.imageName,this.typeName)
      if (this.imageName && this.typeName) {
        this.webRtc.sendToGdevelop("upthingroom", {
          name: this.imageName,
          floor: this.typeName,
        });
        this.showUploadImage = false;
      } else {
        this.$emit("topTips", {
          alert: "Please select a picture.",
          time: 3000,
        });
        return;
      }
    },
    addImage(e) {
      var that = this;
      that.logoFile = e.target.files[0];
      var f = new FileReader();
      f.readAsDataURL(this.$refs.logoImg.files[0]);
      f.onload = function () {
        that.upImgSrc = f.result;
      };
      this.uploadBuildLogo();
    },
    uploadBuildLogo() {
      if (this.logoFile) {
        let formData = new FormData();
        formData.append("icon", this.logoFile);
        formData.append("oldimg", JSON.stringify(this.upOldimg));
        formData.append("roomid", this.roomid);
        let url = this.locationUrl + "/thingroomicon/uploadimg.php";
        axios
          .post(url, formData, {
            headers: { "Content-Type": "multipart/form-data" },
          })
          .then((res) => {
            if (res.data !== "error") {
              this.imageName = res.data;
            }
          });
      }
    },
    closeCustomized() {
      this.$emit("closeCustomized", false);
    },
    uploadLogo() {
      this.$emit("showUploadLogo", true);
    },
    clearUpload() {
      this.moveImg = false;
      this.clearImg = false;
      this.clearUploadImg = !this.clearUploadImg;
    },
    clearBuild(type) {
      this.bulidType = type;
      this.clearUploadImg = false;
      let clearType;
      if (this.bulidType === "clear") {
        this.moveImg = false;
        this.clearImg = !this.clearImg;
        clearType = this.clearImg;
      } else {
        this.clearImg = false;
        this.moveImg = !this.moveImg;
        clearType = this.moveImg;
      }
      $("#mouseImg").attr("src", "");
      let delthingData = { set: clearType === false ? 0 : 1 };
      this.webRtc.sendToGdevelop("delthing", delthingData);
      if (clearType) {
        $(".configureRegion").css("pointer-events", "none");
        if (this.img) {
          $("#" + this.img).removeClass("active");
          this.img = "";
          this.oldImg = null;
        }
      }
    },
    build(status, type, id, name) {
      this.clearImg = false;
      let delthingData = { set: 0 };
      this.webRtc.sendToGdevelop("delthing", delthingData);
      $(".configureRegion").css({ "pointer-events": "all", cursor: "none" });
      let that = this;
      let url;
      if (type === "" && id === "") {
        if (status === 1) {
          that.img = name;
          url = require("../assets/build/" + that.img + ".png");
        } else {
          that.img = id !== "" ? id : name;
          url =
            this.locationUrl +
            "/thingroomicon/userroom/" +
            this.roomid +
            "/" +
            that.img;
        }
        $("#mouseImg").attr("src", url);
        var imgWH2 = new Image();
        imgWH2.src = url;
        imgWH2.onload = function () {
          that.imgX = imgWH2.width / 2;
          that.imgY = imgWH2.height / 2;
        };
      } else {
        this.moveImg = false;
        that.bulidType = "";
        if (status === 1) {
          that.img = type + id;
          url = require("../assets/build/" + that.img + ".png");
        } else {
          that.img = id;
          url =
            this.locationUrl +
            "/thingroomicon/userroom/" +
            this.roomid +
            "/" +
            id;
        }
        if (that.img === that.oldImg) {
          $("#" + that.img).removeClass("active");
          that.img = "";
          that.oldImg = null;
          $("#mouseImg").attr("src", "");
          $(".configureRegion").css("pointer-events", "none");
        } else {
          $("#" + that.oldImg).removeClass("active");
          $("#" + that.img).addClass("active");
          $("#mouseImg").attr("src", url);
          that.oldImg = that.img;
          var imgWH = new Image();
          imgWH.src = url;
          imgWH.onload = function () {
            that.imgX = imgWH.width / 2;
            that.imgY = imgWH.height / 2;
          };
        }
      }
    },
    getMouseXY(e) {
      if (this.img) {
        let puttingData = {
          name: this.img,
          posx: parseInt(e.offsetX + this.imgX + 10),
          posy: parseInt(e.offsetY + this.imgY + 10),
        };
        puttingData.posy = parseInt(
          document.getElementById("games").offsetHeight - puttingData.posy
        );
        // console.log(puttingData);
        this.webRtc.sendToGdevelop("putthing", puttingData);
        if (this.bulidType === "move") {
          this.img = "";
          $("#mouseImg").attr("src", "");
          $(".configureRegion").css("pointer-events", "none");
          let delthingData = { set: 1 };
          this.webRtc.sendToGdevelop("delthing", delthingData);
        }
      }
    },
    mousemove(e) {
      e = window.event;
      $("#mouseImg")
        .css("left", parseInt(e.offsetX + 10) + "px")
        .css("top", parseInt(e.offsetY + 10) + "px");
    },
  },
};
</script>
<style lang="stylus" scoped>
.main
  --cursor
.configureRegion
  cursor var(--cursor), default
  width 100vw
  height 100vh
  position absolute
.customized
  width 260px
  height 600px
  background #314237
  border-radius 20px
  position fixed
  top 20%
  left 40px
  z-index 9
  bottom 20%
  height calc(100% - 40%)
  color #fff
  padding 15px
  text-align left
.close
  text-align right
  cursor pointer
.build
  display flex
  align-items center
  margin-bottom 10px
  .clearImg
    margin-left 20px
    cursor pointer
    &:hover
      content url('../assets/clear2.svg')
    &.active
      content url('../assets/clear2.svg')
  .moveImg
    margin-left 20px
    cursor pointer
    &:hover
      content url('../assets/move2.svg')
    &.active
      content url('../assets/move2.svg')
  .clearUploadImg
    margin-left 20px
    cursor pointer
    width 16px
    &:hover
      content url('../assets/clearUpload2.svg')
    &.active
      content url('../assets/clearUpload2.svg')
.objects
  margin 20px 0 20px 0
  font-size 14px
  width 100%
.list
  display flex
  flex-wrap wrap
  height calc(100% - 170px)
  overflow auto
  .item
    width 50px
    height 50px
    background rgba(255, 255, 255, 0.1)
    border-radius 10px
    display flex
    align-items center
    justify-content center
    cursor pointer
    margin 6px
    border 1px solid #fff0
    &.active
      border 1px solid #60ff98
    &:hover
      border 1px solid #60ff98
    img
      max-width 60%
      max-height 60%
.button
  margin 30px 0
  div
    width 100%
    height 36px
    background rgba(255, 255, 255, 0.1)
    border-radius 12px
    margin 10px 0
    display flex
    justify-content center
    align-items center
    cursor pointer
    opacity 0.8
    &:hover
      opacity 1
.uploadImage
  width 100vw
  height 100vh
  background rgba(20, 22, 39, 0.722)
  position absolute
  z-index 999
  display flex
  justify-content center
  align-items center
  top 0
  .uploadInfo
    border 2px solid rgba(90, 206, 106, 0.3)
    border-radius 6px
    padding 5px
    border-radius 10px
    border 8px solid #383838
    box-shadow 8px 8px 3px -3px #000
    width 760px
    background #f3f3f3
    text-align left
    padding 30px
    p
      font-size 18px
    .close
      display flex
      justify-content center
      align-items center
      color #fff
      width 20px
      height 20px
      cursor pointer
      margin-top -31px
      margin-left 758px
      background #383838
      border-radius 0px 10px
      height 37px
      width 37px
      font-size 22px
    .uploadContent
      display flex
      justify-content center
      margin-top 60px
      margin-bottom 60px
      .image
        width 500px
        height 300px
        background #fff
        border 1px dashed #80808069
        border-radius 12px
        cursor pointer
        .upImgSrc
          width 500px
          height 300px
          display flex
          justify-content center
          align-items center
          position absolute
          img
            max-width 100%
            max-height 100%
        .selectUpImg
          text-align center
          margin-top 80px
          position absolute
          margin-left 130px
      .info
        width 250px
        padding-left 20px
        select
          width 100%
          height 36px
          border 1px solid rgba(255, 255, 255, 0.5)
          border-radius 12px
          padding 0 10px
          option
            line-height 40px
      .button div
        background #fff !important
        font-family 'Silkscreen'
.filePrew
  width 500px !important
  height 300px !important
  margin-left 0 !important
.uploadItem
  position relative
  .uploadClear
    position absolute
    right 2px
    top 0px
    cursor pointer
    img
      width 15px
</style>
