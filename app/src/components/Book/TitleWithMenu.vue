<template>
  <v-menu :v-model="true" absolute offset-y style="max-width: 600px">
    <template v-slot:activator="{ on, attrs }">
      <h1
        class="google-sans-regular pl-6 mb-0 text-center"
        v-bind="attrs"
        v-on="on"
      >
        📔 Books 📔
      </h1>
    </template>

    <v-list>
      <v-list-item
        v-for="item in items"
        :key="item.value"
        link
        @click="changeBookInfosOrderType(item.value)"
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
        { title: "Order by category name", value: 2 },
        { title: "Order by author names", value: 3 },
        { title: "Order by pages count ", value: 4 },
        { title: "Order by pages score", value: 5 },
      ],
    };
  },

  methods: {
    ...mapActions("book", ["changeOrderType"]),
    async changeBookInfosOrderType(val) {
      await this.changeOrderType({ orderType: val });
    },
  },

  computed: {
    ...mapGetters("book", ["getOrderType"]),
  },
};
</script>

<style>
</style>