/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.hadoop.hive.metastore;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hive.metastore.api.Database;
import org.apache.hadoop.hive.metastore.conf.MetastoreConf;
import org.apache.hadoop.hive.metastore.conf.MetastoreConf.ConfVars;
import org.apache.hadoop.hive.metastore.security.HadoopThriftAuthBridge;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * TestRemoteHiveMetaStoreIpAddress.
 *
 * Test which checks that the remote Hive metastore stores the proper IP address using
 * IpAddressListener
 */
public class TestRemoteHiveMetaStoreIpAddress {
  private static final Logger LOG = LoggerFactory.getLogger(TestRemoteHiveMetaStoreIpAddress.class);
  private static Configuration conf;
  private static HiveMetaStoreClient msc;

  @Before
  public void setUp() throws Exception {
    conf = MetastoreConf.newMetastoreConf();


    System.setProperty(ConfVars.EVENT_LISTENERS.toString(), IpAddressListener.class.getName());
    MetaStoreTestUtils.setConfForStandloneMode(conf);
    int port = MetaStoreTestUtils.startMetaStoreWithRetry(HadoopThriftAuthBridge.getBridge(), conf);
    LOG.debug("Starting MetaStore Server on port " + port);
    MetastoreConf.setVar(conf, ConfVars.THRIFT_URIS, "thrift://localhost:" + port);

    msc = new HiveMetaStoreClient(conf);
  }

  @Test
  public void testIpAddress() throws Exception {
    Database db = new Database();
    db.setName("testIpAddressIp");
    msc.createDatabase(db);
    msc.dropDatabase(db.getName());
  }
}
