<template>
  <div>
    <div
      class="company officeBg"
      v-if="showCompany && officeStatus === 0"
      @click="closeCompany()"
    >
      <div @click="cancelBubble($event)">
        <div class="officeCon">
          <p class="close_frame" @click="closeCompany()"><img src="../assets/close.svg"/></p>
          <div class="bgImg">
            <img class="left" src="../assets/bg-left.png" />
          </div>
          <h2>PICK AN OFFICE TO ENTER</h2>
          <div class="info">
            <div
              class="officeList"
              :style="officeList.length <= 1 ? 'justify-content: center;' : ''"
            >
              <div v-for="(item, index) in officeList" :key="index">
                <div
                  :class="{ item: true, active: office === item.mapid }"
                  @click="setOfficeInfo(item.mapid, item.address, item.type)"
                >
                  <img v-if="item.img === ''" src="../assets/home.png" />
                  <img
                    v-else-if="item.type === 1"
                    :src="locationUrl + '/roomicon/icon/' + item.img"
                  />
                  <img
                    v-else-if="item.type === 2"
                    :src="locationUrl + '/thingroomicon/icon/' + item.img"
                  />
                  <p>
                    {{ item.name }}
                  </p>
                </div>
              </div>
            </div>
            <div class="enterButton" @click="joinOffice(office, officeAddress)">
              <div class="text">ENTER</div>
            </div>
          </div>
          <div class="bgImg bgImg_right">
            <img class="right" src="../assets/taskright.png" />
          </div>
        </div>
      </div>
    </div>

    <div
      class="createOff officeBg"
      v-if="showCompany && officeStatus === 1"
      @click="closeCompany()"
    >
      <div class="officeCon" @click="cancelBubble($event)">
        <p class="close_frame" @click="closeCompany()"><img src="../assets/close.svg"/></p>
        <div class="bgImg">
          <img class="left" src="../assets/bg-left.png" />
        </div>
        <h2>Create Flex Space</h2>
        <div class="textInfo">
          Sorry, you are not invited. Please submit an application and kindly
          wait for your invite link.
        </div>
        <div class="enterButton" @click="getOfficeSpace()">
          <div class="text">APPLY</div>
        </div>
        <div class="bgImg bgImg_right">
          <img class="right" src="../assets/taskright.png" />
        </div>
      </div>
    </div>

    <div
      class="createOff officeBg"
      v-if="showCompany && officeStatus === 2"
      @click="closeCompany()"
    >
      <div class="officeCon" @click="cancelBubble($event)">
        <p class="close_frame" @click="closeCompany()"><img src="../assets/close.svg"/></p>
        <div class="bgImg">
          <img class="left" src="../assets/bg-left.png" />
        </div>
        <div class="textInfo">
          Sorry, your application has been declined due to some reasons. Please
          try again later or request an invite link from a friend.
        </div>
        <div class="enterButton" @click="closeCompany()">
          <div class="text">FINISH</div>
        </div>
        <div class="bgImg bgImg_right">
          <img class="right" src="../assets/taskright.png" />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "CompanyList",
  data() {
    return {};
  },
  props: [
    "showCompany",
    "officeStatus",
    "officeList",
    "office",
    "officeAddress",
    "officeType",
    "locationUrl",
  ],
  computed: {},
  created() {},
  methods: {
    closeCompany() {
      this.$emit("closeCompany");
    },
    cancelBubble(event) {
      this.$emit("cancelBubble", event);
    },
    joinOffice(office, officeAddress) {
      this.$emit("joinOffice", {
        office: office,
        officeAddress: officeAddress,
      });
    },
    getOfficeSpace() {
      window.open("https://forms.gle/DzjfYHvMEg16zN5B7", "_blank");
    },
    setOfficeInfo(office, officeAddress, officeType) {
      this.$emit("setOfficeInfo", {
        office: office,
        officeAddress: officeAddress,
        officeType:officeType
      });
    },
  },
};
</script>
<style lang="stylus" scoped>
@import '../views/home.styl'
</style>
