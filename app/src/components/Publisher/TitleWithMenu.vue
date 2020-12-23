<template>
  <v-menu :v-model="true" absolute offset-y style="max-width: 600px">
    <template v-slot:activator="{ on, attrs }">
      <h1
        class="google-sans-regular pl-6 mb-0 text-center"
        v-bind="attrs"
        v-on="on"
      >
        🌇 Publishers 🌇
      </h1>
    </template>

    <v-list>
      <v-list-item
        v-for="item in items"
        :key="item.value"
        link
        @click="changePublishersOrderType(item.value)"
      >
        <v-list-item-title
          :class="
            getOrderType === item.value
              ? 'secondary--text'
              : 'black--text' + 'google-sans-regular'
          "
        >
          {{ item.title }}
        </v-list-item-title>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>
import { mapActions } from "vuex";
import { mapGetters } from "vuex";
export default {
  name: "TitleWithMenu",
  data() {
    return {
      showMenu: false,
      items: [
        { title: "Order by name", value: 1 },
        { title: "Order by book count", value: 2 },
      ],
    };
  },

  methods: {
    ...mapActions("publisher", ["changeOrderType"]),
    async changePublishersOrderType(val) {
      await this.changeOrderType({ orderType: val });
    },
  },

  computed: {
    ...mapGetters("publisher", ["getOrderType"]),
  },
};
</script>

<style>
</style>